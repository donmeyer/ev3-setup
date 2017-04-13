#!/usr/bin/env python

from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer
from pyftpdlib.authorizers import UnixAuthorizer
from pyftpdlib.filesystems import UnixFilesystem


authorizer = UnixAuthorizer(rejected_users=["root"], require_valid_shell=True)
	
handler = FTPHandler
handler.authorizer = authorizer

handler.abstracted_fs = UnixFilesystem

address = ('', 21)
ftpd = FTPServer(address, handler)

ftpd.serve_forever()
