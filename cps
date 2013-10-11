#!/usr/bin/env python
import os
import subprocess
import shutil
import sys
from time import strftime

def _samedir(src,dst):
	return (os.path.abspath(src)==
		os.path.abspath(dst))
def copytree(src,dst):
	"""subprocess.call(['cp', '-rf', src, dst])"""
	if not _samedir(src, dst):

		for f in os.listdir(src):
			s=os.path.join(src,f)
			d=os.path.join(dst,f)
			if os.path.isfile(s):
				if os.path.islink(s):
					linkto = os.readlink(s)
					print("Not copy a link file :%s" % (linkto))
				else:
					try:
						shutil.copy(s,d)
					except OSError as e: 
						print "shutil.copy error src is:"+s
			if os.path.isdir(s):
				if not os.path.isdir(d):
					os.mkdir(d)
				copytree(s, d)


def copystruct(src,dst):
	print("src is :%s" % (src))
	print("dst is :%s" % (dst))
	if os.path.isfile(src):
		src_dirname = os.path.dirname(src)
	elif os.path.isdir(src):
		src_dirname = src
	else:
		print ("%s is not exist" % (src))
		return

	if not os.path.isdir(dst):
		print("dst is not a dir")
		return

	"""src_dirname=os.path.dirname(src)"""

	"""Do not use os.path.join(dst,src_dirname) due to """
	"""the src_dirname will be thrown if it's a absolute path"""
	if src_dirname.startswith('/'):
		src_dirname = src_dirname[1:]
	if dst == '' or dst.endswith('/'):
		dirpath = dst + src_dirname
	else:
		dirpath = dst + '/' + src_dirname

	if _samedir(src_dirname,dirpath):
		print("`%s` and `%s` are the same dir" % (src_dirname, dst))

	dirpath=os.path.normpath(dirpath)
	

	if not os.path.isdir(dirpath):
		os.makedirs(dirpath)
	if os.path.isfile(src):
		shutil.copy(src,dirpath)
	if os.path.isdir(src):
		copytree(src,dirpath)
def backup_git():
	p = subprocess.Popen('git status | grep "modified"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

	s = p.stdout.readlines()
	
	t = strftime("%Y%m%d%H%M%S")

	bkdir="patch-"+t

	if not os.path.isdir(bkdir):
		os.mkdir(bkdir)

	for index in range(0,len(s)):

		s[index]=s[index][14:]
		s[index]=s[index].strip("\n")
		copystruct(os.path.abspath(s[index]),bkdir)

if __name__ == "__main__":
	if(len(sys.argv)==3):
		copystruct(sys.argv[1],sys.argv[2])
	if(len(sys.argv)==2 and sys.argv[1]=="git" ):
		backup_git()
	if(len(sys.argv)==1):
		print("NAME\ncps  - copy files and directories with structure\n\nUsage:\ncps git:\ncps SOURCE DEST:\n")

		

	
