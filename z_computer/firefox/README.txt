FIREFOX RAM PROFILE SETUP
=========================

Purpose:
Firefox uses a profile stored in RAM at:

/dev/shm/firefox-kevin

The normal Firefox profile path is a symbolic link to that RAM directory:

/home/kevin/.mozilla/firefox/a8o3uubf.kevin-1706213665373
    -> /dev/shm/firefox-kevin


LIVE FILES
==========

Restore script:
/usr/local/bin/firefox-ram-restore

Save script:
/usr/local/bin/firefox-ram-save

runit restore service:
/etc/sv/firefox-restore/run

runit save service:
/etc/sv/firefox-save/run


BACKUP COPIES
=============

This directory:

/home/kevin/z_computer/firefox-ram/

Contains copies of the scripts and runit service files.


FIREFOX PROFILE
===============

RAM profile:
/dev/shm/firefox-kevin

Disk profile:
/home/kevin/.mozilla/firefox/a8o3uubf.kevin-1706213665373.disk

Original backup:
/home/kevin/.mozilla/firefox-backup/a8o3uubf.kevin-1706213665373


HOW IT WORKS
============

At boot, firefox-restore copies the disk profile into /dev/shm.

Firefox then uses the RAM profile through the symbolic link.

The firefox-save service synchronizes the RAM profile back to disk
every 15 minutes.

When the save service stops, it performs one final synchronization.


IMPORTANT
=========

/dev/shm is RAM-backed and is lost after reboot or power loss.

The disk profile is therefore important.

Do not delete the .disk profile or the backup unless this setup is
intentionally being removed.

System:
Void Linux
Init system: runit
Firefox profile size: approximately 2.1 GiB
RAM: approximately 30 GiB
/dev/shm: approximately 16 GiB
