###
# 
# Library for working with JSON messages for Salvus.
#
# (c) 2012, William Stein
# 
# We use functions to work with messages to ensure some level of
# consistency, defaults, and avoid errors from typos, etc.
# 
### 

SalvusMessage = exports? and exports or @SalvusMessage = {}

# hub --> sage_server and browser --> hub
SalvusMessage.start_session = (max_walltime=3600, max_cputime=3600, max_numfiles=1000, max_vmem=2048) -> 
    event:'start_session'
    max_walltime:max_walltime
    max_cputime:max_cputime
    max_numfiles:max_numfiles
    max_vmem:max_vmem

# hub --> browser
SalvusMessage.new_session = (uuid, max_walltime, max_cputime, max_numfiles, max_vmem) ->
    event:'new_session'
    uuid:uuid
    max_walltime:max_walltime
    max_cputime:max_cputime
    max_numfiles:max_numfiles
    max_vmem:max_vmem

# sage_server --> hub
SalvusMessage.session_description = (pid) ->
    event:'session_description'
    pid:pid

# browser --> hub --> sage_server
SalvusMessage.send_signal = (pid, signal=2) -> # 2=SIGINT
    event:'send_signal'
    pid:pid
    signal:signal

# client <----> server               
SalvusMessage.terminate_session = (reason='') ->
    event:'terminate_session'
    reason:reason
    done:true

# browser --> hub --> sage_server
SalvusMessage.execute_code = (id, code, preparse=true) ->
    event:'execute_code'
    id:id
    code:code
    preparse:preparse
        
# sage_server --> hub_i --> hub_j --> browser
SalvusMessage.output = (id, stdout=null, stderr=null, done=null) ->
    event:'output'
    id:id
    stdout:stdout
    stderr:stderr
    done:done

# hub --> browser
SalvusMessage.logged_in = (name) ->
    event:'logged_in'
    name:name
