function deezer-cli
    pbpaste | read _clipboard
    echo $argv | pbcopy
    open /Applications/Deezer.app/
    cliclick \
        kd:cmd kp:arrow-left ku:cmd \
        t:s \
        kd:cmd t:a ku:cmd \
        kd:cmd t:v ku:cmd \
        kp:enter
    echo $_clipboard | pbcopy
end
