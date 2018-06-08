#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os


def installVim():
    localVim = 'vim-init/init.vim'
    os.system('echo source %s >> ~/.vimrc\n' %
              os.path.join(os.getcwd(), localVim))
    # os.system('cp %s ~/.ycm_extra_conf.py\n' % os.path.join( os.getcwd(),localYcm))


def installGit():
    localGit = 'git/gitconfig'
    GitcfgPath = os.path.join(os.getcwd(), localGit)
    os.system('cp %s ~/.gitconfig\n' % GitcfgPath)


if __name__ == '__main__':
    installVim()
    installGit()
