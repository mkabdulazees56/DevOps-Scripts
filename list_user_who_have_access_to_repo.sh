#!/bin/bash

# -------------------------------
# GitHub Repository Access Checker
# -------------------------------
# Usage:
# 1. Export your GitHub username and token:
#    export username="your_github_username"
#    export token="your_github_token"
#
# 2. Run the script with organization/user and repository name:
#    ./list-users.sh <owner> <repo>
#
# Example:
#    ./list-users.sh mk-digitel-solutions test_shell_scripting

# GitHub API Base URL
API_URL="https://api.github.com"

# Credentials from environment
USERNAME=$username
TOKEN=$token

# Input Parameters
REPO_OWNER=$1
REPO_NAME=$2

# -------------------------------
# Helper: Print Error and Exit
# -------------------------------
function print_error_and_exit {
    echo "Error: $1"
    exit 1
}

# -------------------------------
# Helper: Validate Inputs
# -------------------------------
function validate_inputs {
    if [[ -z "$USERNAME" || -z "$TOKEN" ]]; then
        print_error_and_exit "GitHub username or token not set. Please export them first."
    fi

    if [[ -z "$REPO_OWNER" || -z "$REPO_NAME" ]]; then
        print_error_and_exit "Repository owner and name must be provided as arguments."
    fi
}

# -------------------------------
# Helper: Make Authenticated GET Request
# -------------------------------
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# -------------------------------
# Helper: Parse Collaborators with Read Access
# -------------------------------
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Call GitHub API and extract logins of users with 'pull' (read) access
    collaborators=$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')

    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# -------------------------------
# Main Script Execution
# -------------------------------
validate_inputs
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
