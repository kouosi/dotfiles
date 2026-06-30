#!/bin/env python

import os, sys, subprocess, argparse
from pathlib import Path

def get_git_origin(repo_path):
    try:
        result = subprocess.run(
            ['git', 'config', '--get', 'remote.origin.url'],
            cwd=repo_path,
            capture_output=True,
            text=True,
            check=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError:
        pass
    except Exception as e:
        print(f"Error checking {repo_path}: {e}")
    return "<No origin URL found>"

def is_git_repository(folder_path):
    return os.path.exists(os.path.join(folder_path, '.git'))

def get_all_repo_links(repos_folder):
    repos_folder = Path(repos_folder)
    repo_links = {}
    if not repos_folder.exists():
        print(f"Error: Folder '{repos_folder}' does not exist")
        return repo_links
    if not repos_folder.is_dir():
        print(f"Error: '{repos_folder}' is not a directory")
        return repo_links
    for item in repos_folder.iterdir():
        if item.is_dir() and is_git_repository(item):
            repo_links[item.name] = get_git_origin(item)
    return repo_links

def main():
    parser = argparse.ArgumentParser(description ='Get git origin URL from git folders')
    parser.add_argument("dir", help="Directory containing the git folders")
    parser.add_argument("-c", "--clone-cmd", action="store_true", help="Get clone command")
    args = parser.parse_args()
    repo_links = get_all_repo_links(args.dir)
    if not repo_links:
        print("No Git repositories found or folder is empty")
        return
    for repo_name, origin_url in repo_links.items():
        if args.clone_cmd:
            print(f"git clone --depth=1 {origin_url} {repo_name}")
        else:
            print(f"{origin_url}")

if __name__ == "__main__":
    main()
