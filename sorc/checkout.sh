#!/bin/sh
set -xu

topdir=$(pwd)
echo $topdir

echo fv3gfs coupled checkout ...
if [[ ! -d fv3gfs.fd ]] ; then
    rm -f ${topdir}/checkout-fv3gfs.log
    git clone --recursive gerrit:EMC_FV3-MOM6-CICE5 fv3gfs.fd >> ${topdir}/checkout-fv3gfs.log 2>&1
    cd fv3gfs.fd
    # The following corresponds to a commit on the "usingSST" branch 
    git checkout 007e14667eb3c156a1746357de342033285967d3
    git submodule update --init --recursive
    cd ${topdir}
else
    echo 'Skip.  Directory fv3gfs.fd already exists.'
fi

echo gsi checkout ...
if [[ ! -d gsi.fd ]] ; then
    rm -f ${topdir}/checkout-gsi.log
    git clone --recursive gerrit:ProdGSI gsi.fd >> ${topdir}/checkout-gsi.fd.log 2>&1
    cd gsi.fd
    git checkout fv3da.v1.0.15
    git submodule update
    cd ${topdir}
else
    echo 'Skip.  Directory gsi.fd already exists.'
fi

echo EMC_post checkout ...
if [[ ! -d gfs_post.fd ]] ; then
    rm -f ${topdir}/checkout-gfs_post.log
    git clone --recursive gerrit:EMC_post gfs_post.fd >> ${topdir}/checkout-gfs_post.log 2>&1
    cd gfs_post.fd
    git checkout ncep_post.v8.0.16
    cd ${topdir}
else
    echo 'Skip.  Directory gfs_post.fd already exists.'
fi

exit 0
