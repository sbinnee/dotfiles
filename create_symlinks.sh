#!/bin/bash
# Written by Claude 4.0

# Usage: ./create_symlinks.sh [options]

set -e

# Default options
DRY_RUN=false
FORCE=false
VERBOSE=false
AUTO_CONFIRM=false
EXCLUDE_PATTERNS=()

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_conflict() { echo -e "${MAGENTA}[CONFLICT]${NC} $1"; }
log_verbose() { [[ "$VERBOSE" == true ]] && echo -e "${NC}[VERBOSE]${NC} $1"; }

show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

Create symlinks from git repository files to home directory.

OPTIONS:
    -n, --dry-run       Show what would be done without making changes
    -f, --force         Don't create backups, overwrite existing files
    -y, --yes           Automatically confirm all conflicts
    -v, --verbose       Enable verbose output
    -e, --exclude PATTERN  Exclude files matching pattern (can be used multiple times)
    -i, --input-repo    Input repo (default to current dir)
    -h, --help          Show this help message

EXAMPLES:
    $0                          # Process current directory
    $0 -n ~/dotfiles            # Dry run
    $0 -e "*.md" -e "LICENSE"   # Exclude markdown files and LICENSE
EOF
}

# Function to ask user for confirmation
ask_confirmation() {
    local prompt="$1"
    local default="$2"  # y/n

    if [[ "$AUTO_CONFIRM" == true ]]; then
        echo "y"
        return
    fi

    while true; do
        if [[ "$default" == "y" ]]; then
            read -p "$prompt [Y/n]: " -r response
            response=${response:-y}
        else
            read -p "$prompt [y/N]: " -r response
            response=${response:-n}
        fi

        case $response in
            [Yy]|[Yy][Ee][Ss])
                echo "y"
                return
                ;;
            [Nn]|[Nn][Oo])
                echo "n"
                return
                ;;
            *)
                echo "Please answer yes or no."
                ;;
        esac
    done
}

# Function to show file differences
show_diff() {
    local file1="$1"
    local file2="$2"
    local filename="$3"

    echo -e "\n${YELLOW}=== Content differences for $filename ===${NC}"
    echo -e "${BLUE}Repository version:${NC} $file1"
    echo -e "${BLUE}Home directory version:${NC} $file2"
    echo

    if command -v diff &> /dev/null; then
        # Use diff with color if available
        if diff --color=always "$file2" "$file1" 2>/dev/null; then
            echo "Files are identical (this shouldn't happen)"
        fi
    else
        # Fallback to basic comparison
        echo "--- Home version ($file2)"
        echo "+++ Repository version ($file1)"
        echo
        echo "Install 'diff' command for better comparison display"
    fi
    echo -e "${YELLOW}=======================================${NC}\n"
}


# Function to check if file should be excluded
should_exclude() {
    local file="$1"
    for pattern in "${EXCLUDE_PATTERNS[@]}"; do
        if [[ "$file" == $pattern ]]; then
            return 0
        fi
    done
    return 1
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        -y|--yes)
            AUTO_CONFIRM=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -e|--exclude)
            EXCLUDE_PATTERNS+=("$2")
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -i|--input-repo)
            REPO_PATH="$2"
            shift 2
            ;;
        -*)
            log_error "Unknown option: $1"
            show_help
            exit 1
            ;;
        *)
            log_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Get repository path (default to current directory)
REPO_PATH="${REPO_PATH:-.}"
REPO_PATH=$(realpath "$REPO_PATH")

# Validation
if [ ! -d "$REPO_PATH" ]; then
    log_error "Directory $REPO_PATH does not exist"
    exit 1
fi

if [ ! -d "$REPO_PATH/.git" ]; then
    log_error "$REPO_PATH is not a git repository"
    exit 1
fi

log_info "Repository: $REPO_PATH"
log_info "Target: $HOME"
[[ "$DRY_RUN" == true ]] && log_warning "DRY RUN MODE - No changes will be made"
[[ "$AUTO_CONFIRM" == true ]] && log_warning "AUTO-CONFIRM MODE - All conflicts will be automatically resolved"

cd "$REPO_PATH"
files=$(git ls-files)

if [[ -z "$files" ]]; then
    log_warning "No files found in the git repository"
    exit 0
fi

# Statistics
total_files=0
created_links=0
replaced_links=0
skipped_files=0
conflicts_found=0
conflicts_resolved=0

# Arrays to store conflicted files for summary
declare -a conflicted_files=()
declare -a skipped_conflicts=()


while IFS= read -r file; do
    [[ -z "$file" ]] && continue

    # Check exclusions
    if should_exclude "$file"; then
        log_verbose "Excluding: $file"
        continue
    fi

    total_files=$((total_files + 1))
    source_file="$REPO_PATH/$file"
    target_file="$HOME/$file"
    target_dir="$(dirname "$target_file")"

    log_verbose "Processing: $file"

    if [[ ! -f "$source_file" ]]; then
        log_warning "Source file missing: $source_file"
        skipped_files=$((skipped_files + 1))
        continue
    fi

    # Create directory
    if [[ ! -d "$target_dir" ]]; then
        if [[ "$DRY_RUN" == false ]]; then
            mkdir -p "$target_dir"
        fi
        log_info "Creating directory: $target_dir"
    fi

    # Handle existing files
    if [[ -e "$target_file" || -L "$target_file" ]]; then
        # Check if it's already a correct symlink
        if [[ -L "$target_file" && "$(readlink "$target_file")" == "$source_file" ]]; then
            log_verbose "Symlink already correct: $target_file"
            skipped_files=$((skipped_files + 1))
            continue
        fi

        # If it's a regular file, check if content differs
        if [[ -f "$target_file" && ! -L "$target_file" ]]; then
            if ! cmp -s "$source_file" "$target_file"; then
                conflicts_found=$((conflicts_found + 1))
                log_conflict "Content differs: $file"

                # Show the differences
                show_diff "$source_file" "$target_file" "$file"

                if [[ "$DRY_RUN" == false ]]; then
                    # Ask user what to do
                    echo "Options:"
                    echo "  y) Replace with symlink (current file will be backed up)"
                    echo "  n) Skip this file"
                    echo "  q) Quit script"

                    response=$(ask_confirmation "Replace $file with symlink?" "n")

                    case $response in
                        y)
                            log_info "User chose to replace $file"
                            conflicted_files+=("$file")
                            conflicts_resolved=$((conflicts_resolved + 1))
                            break
                            ;;
                        n)
                            log_info "User chose to skip $file"
                            skipped_conflicts+=("$file")
                            skipped_files=$((skipped_files + 1))
                            continue
                            ;;
                        q)
                            log_info "User requested to quit"
                            exit 0
                            ;;
                        *)
                            echo "Invalid option. Please choose y, n, d, or q."
                            continue
                            ;;
                    esac
                else
                    log_info "User chose to skip $file"
                    skipped_conflicts+=("$file")
                    skipped_files=$((skipped_files + 1))
                fi
            else
                log_info "File content identical, replacing with symlink: $file"
            fi
        fi

        # Backup existing file/symlink
        if [[ "$FORCE" == false ]]; then
            backup_file="${target_file}.backup.$(date +%Y%m%d_%H%M%S)"
            if [[ "$DRY_RUN" == false ]]; then
                mv "$target_file" "$backup_file"
            fi
            log_warning "Backing up: $target_file -> $backup_file"
        else
            if [[ "$DRY_RUN" == false ]]; then
                rm -f "$target_file"
            fi
            log_warning "Removing: $target_file"
        fi
        replaced_links=$((replaced_links + 1))
    else
        created_links=$((created_links + 1))
    fi

    # Create symlink
    if [[ "$DRY_RUN" == false ]]; then
        ln -s "$source_file" "$target_file"
    fi
    log_success "Created symlink: $target_file -> $source_file"
done <<< "$files"

# Summary
echo
log_info "=== SUMMARY ==="
log_info "Total files processed: $total_files"
log_success "New symlinks created: $created_links"
log_warning "Files replaced: $replaced_links"
log_info "Files skipped: $skipped_files"

if [[ $conflicts_found -gt 0 ]]; then
    echo
    log_conflict "=== CONFLICTS DETECTED ==="
    log_conflict "Total conflicts found: $conflicts_found"
    log_conflict "Conflicts resolved: $conflicts_resolved"
    log_conflict "Conflicts skipped: ${#skipped_conflicts[@]}"

    if [[ ${#conflicted_files[@]} -gt 0 ]]; then
        echo
        log_info "Files with conflicts that were resolved:"
        for file in "${conflicted_files[@]}"; do
            echo "  - $file"
        done
    fi

    if [[ ${#skipped_conflicts[@]} -gt 0 ]]; then
        echo
        log_warning "Files with conflicts that were skipped:"
        for file in "${skipped_conflicts[@]}"; do
            echo "  - $file"
        done
        echo
        log_warning "You may want to manually review these files later."
    fi
fi

if [[ $replaced_links -gt 0 && "$FORCE" == false ]]; then
    echo
    log_info "Backup files can be found with:"
    echo "find $HOME -name '*.backup.*' -type f"
fi

log_success "Process completed!"
