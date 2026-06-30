#!/bin/env python

import os, uuid, argparse

def scramble_files(directory, mapping_file, verbose, force):
    if not os.path.exists(directory):
        print("Error: Directory not found.")
        return
    if os.path.exists(mapping_file) and not force:
            print(f"Error: Mapping file '{mapping_file}' already exists. Use -f/--force to overwrite.")
            return
    with open(mapping_file, "a") as f:
        for filename in os.listdir(directory):
            if filename == mapping_file or os.path.isdir(os.path.join(directory, filename)):
                continue
            random_name = str(uuid.uuid4())
            old_path = os.path.join(directory, filename)
            new_path = os.path.join(directory, random_name)

            os.rename(old_path, new_path)
            f.write(f"{random_name}|{filename}\n")
            if verbose:
                print(f"{filename} -> {random_name}")

def restore_files(directory, mapping_file, verbose):
    if not os.path.exists(mapping_file):
        print("Error: Mapping file not found!")
        return
    with open(mapping_file, "r") as f:
        lines = f.readlines()
    remaining_mappings = []
    for line in lines:
        if "|" not in line: continue
        random_name, original_name = line.strip().split("|")
        random_path = os.path.join(directory, random_name)
        original_path = os.path.join(directory, original_name)
        if os.path.exists(random_path):
            os.rename(random_path, original_path)
            if verbose:
                print(f"{random_name} -> {original_name}")
        else:
            remaining_mappings.append(line)
    if remaining_mappings:
        with open(mapping_file, "w") as f:
            f.writelines(remaining_mappings)
    else:
        os.remove(mapping_file)
        if verbose:
            print(f"All files restored; deleted mapping file '{mapping_file}'.")

def main():
    global VERBOSE, FORCE
    parser = argparse.ArgumentParser(
        description ='Scramble and Restore file names according to mapping'
    )
    parser.add_argument("dir", help="Directory containing the files to process")
    grp = parser.add_mutually_exclusive_group()
    grp.add_argument("-s", "--scramble", action="store_true", help="Scramble file names (default)")
    grp.add_argument("-r", "--restore", action="store_true", help="Restore original file names")
    parser.add_argument("-m", "--mapping-file", default=".file.mappings",
        help="Path to the mapping file (default: .file.mappings)"
    )
    parser.add_argument("-v", "--verbose", action="store_true", default=False,
        help="Print verbose output"
    )
    parser.add_argument("-f", "--force", action="store_true",
        help="Force overwrite of existing mapping file when scrambling"
    )
    args = parser.parse_args()
    if args.restore:
        restore_files(args.dir, args.mapping_file, args.verbose)
    else:
        scramble_files(args.dir, args.mapping_file, args.verbose, args.force)

if __name__ == "__main__":
    main()
