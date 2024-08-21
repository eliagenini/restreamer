#!/bin/bash

function config_supervisord {
    echo ''
    echo "[program:ffmpeg-$1]"
    echo "command=/usr/src/restream.sh '$1' '$2'"
    echo 'autostart=true'
    echo 'autorestart=true'
    echo 'startretries=5'
    echo 'numprocs=1'
    echo 'startsecs=0'
    echo 'user=%(ENV_USER)s'
    echo 'process_name=%(program_name)s_%(process_num)02d'
    echo 'stderr_logfile=/var/log/supervisor/%(program_name)s_stderr.log'
    echo 'stderr_logfile_maxbytes=10MB'
    echo 'stdout_logfile=/var/log/supervisor/%(program_name)s_stdout.log'
    echo 'stdout_logfile_maxbytes=10MB'
} >> /usr/src/supervisord.conf

URL=$STREAM_URL
config_supervisord "live" "${URL}"
cat /usr/src/supervisord.conf

/usr/bin/supervisord -c /usr/src/supervisord.conf