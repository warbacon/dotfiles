function run
    argparse --min-args=1 -- $argv
    or return 1

    set -l file $argv[1]

    set -l args $argv[2..]

    switch (path extension $file)
        case .java
            javac $file
            java (path change-extension "" $file) $args
            rm *.class
        case .cpp .c
            set -l bin (path change-extension "" $file)
            if g++ $file -o $bin
                ./$bin $args
                rm $bin
            end
        case .py
            python $file $args
        case "*"
            printf "%sUnknown file extension.%s\n" (set_color red --bold) \
                (set_color reset)
            return 1
    end
end
