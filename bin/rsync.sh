echo "Starting rsync..."
# export GVFS=~/.gvfs/photo\ on\ phoenix/
export GVFS=/run/user/1000/gvfs/smb-share:server=phoenix.local,share=photo/
# --dry-run
rsync -ahv --no-p --no-o --no-g --delete --delete-delay --progress --exclude "/#recycle"  /media/XtraSpaceNoCrypt/Photos/ $GVFS
exec $SHELL

