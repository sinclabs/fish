function postexec_test --on-event fish_postexec
    if test $argv[1] != c -a $argv[1] != clear
        echo
    end
end
