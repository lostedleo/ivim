#!/usr/bin/env python
# coding=utf-8
import os
import sys
import getopt

# find directorys by filetype
class FindByFileType:
    def exist_file(self, path, suffix, dirs):
        items = os.listdir(path)
        for name in items:
            full_path = path + "/" + name
            if os.path.isdir(full_path):
                self.exist_file(full_path, suffix, dirs)
            else:
                if name.endswith("." + suffix):
                    dirs.add(path)

    def list_dirs(self, path, suffix):
        dirs = set()
        self.exist_file(path, suffix, dirs)
        return dirs

def usage():
    print sys.argv[0] + ' -p path -t suffix'
    print sys.argv[0] + ' -h get help info'

def main():
    opts, args = getopt.getopt(sys.argv[1:], "hp:t:", ["help", "path=", "type="])
    path = '.'
    suffix = ''
    for op, value in opts:
        if op == '-p' or op == '--path':
            path = value
        elif op == '-t' or op == '--type':
            suffix = value
        elif op == '-h' or op == '--help':
            usage()
            sys.exit(0)

    if suffix == "":
        usage()
        sys.exit(-1)

    find_dirs = FindByFileType()
    dirs = find_dirs.list_dirs(path, suffix)
    if len(dirs):
        for value in dirs:
            print '\'-I\',\"' + value + '\",'

if __name__ == '__main__':
    main()

