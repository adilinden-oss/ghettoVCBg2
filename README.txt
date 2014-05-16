ghettoVCBg2 - Free alternative for backing up VMs in ESXi

Credits for this go to William Lam and the VMware community.
Please refer to the original source for this script:
http://communities.vmware.com/docs/DOC-9843

This is to keep track of my modifications to the ghettoVCBg2 script to make it fit my particular environment. Please refer to the original unless you really want to subject yourself to what I have done.

Synopsis: ./ghettoVCBg2.pl OPTIONS

Command-specific options:
   --backup_datastore
      Name of backup destination datastore
   --backup_directory
      Name of backup destination directory
   --backup_rotation
      Number of backups for a given VM before deletion
   --config_dir
      Name of directory containing VM(s) backup configurations
   --dryrun (default '0')
      Set to 1 to enable dryrun mode (default 0)
   --email_subject
      Prepend string to email subject
   --output (default '/tmp/ghettoVCBg2.log')
      Full path to output log (default /tmp/ghettoVCBg2.log)
   --vmlist (required)
      A file containing a list of virtual machine(s) to be backed up on host

Common VI options:
   --config (variable VI_CONFIG)
      Location of the VI Perl configuration file
   --credstore (variable VI_CREDSTORE)
      Name of the credential store file defaults to <HOME>/.vmware/credstore/vicredentials.xml on Linux and <APPDATA>/VMware/credstore/vicredentials.xml on Windows
   --encoding (variable VI_ENCODING, default 'utf8')
      Encoding: utf8, cp936 (Simplified Chinese), iso-8859-1 (German), shiftjis (Japanese)
   --help
      Display usage information for the script
   --passthroughauth (variable VI_PASSTHROUGHAUTH)
      Attempt to use pass-through authentication
   --passthroughauthpackage (variable VI_PASSTHROUGHAUTHPACKAGE, default 'Negotiate')
      Pass-through authentication negotiation package
   --password (variable VI_PASSWORD)
      Password
   --portnumber (variable VI_PORTNUMBER)
      Port used to connect to server
   --protocol (variable VI_PROTOCOL, default 'https')
      Protocol used to connect to server
   --savesessionfile (variable VI_SAVESESSIONFILE)
      File to save session ID/cookie to utilize
   --server (variable VI_SERVER, default 'localhost')
      VI server to connect to. Required if url is not present
   --servicepath (variable VI_SERVICEPATH, default '/sdk/webService')
      Service path used to connect to server
   --sessionfile (variable VI_SESSIONFILE)
      File containing session ID/cookie to utilize
   --url (variable VI_URL)
      VI SDK URL to connect to. Required if server is not present
   --username (variable VI_USERNAME)
      Username
   --verbose (variable VI_VERBOSE)
      Display additional debugging information
   --version
      Display version information for the script

