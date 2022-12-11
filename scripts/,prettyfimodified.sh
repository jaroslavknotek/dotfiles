# applies python formater `black` to all python files that has been modified or created (tracked by git status)

prettifymodified_func(){
    git status -s| grep "\.py" | grep "[AM] .*" | while read line ; do black ${line:2} -q; echo "${line:2} formatted" ; done
    git status -s| grep "\.py" | grep "[AM] .*" | while read line ; do isort ${line:2} --profile black; echo "${line:2} formatted" ; done
    
    # turn "old_file -> new_file" into " new_file"
    git status -s| grep "\.py" | grep "R .*" | while read line ; do black $(echo  ${line:2} | cut -d'>' -f2) -q; echo "${line:2} sorted" ; done
    git status -s| grep "\.py" | grep "R .*" | while read line ; do isort $(echo  ${line:2} | cut -d'>' -f2) --profile black; echo "${line:2} sorted" ; done
}
prettifymodified_func

