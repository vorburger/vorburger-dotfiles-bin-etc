function t -d "Test code in current or parent directory (using various strategies)"
    set -l start_dir (pwd)
    while true
        if test -f "flake.nix"
            nix flake check
            cd "$start_dir"
            return 0
        else if test -x "test.bash"
            ./test.bash
            cd "$start_dir"
            return 0
        else if test -x "test.sh"
            ./test.sh
            cd "$start_dir"
            return 0
        else if test -x "test"
            ./test
            cd "$start_dir"
            return 0
        else if test -f "pom.xml"
            if test -x "mvnw"
                ./mvnw test
            else
                mvn test
            end
            cd "$start_dir"
            return 0
        else if test -f "build.gradle"
            if test -x "gradlew"
                ./gradlew test
            else
                gradle test
            end
            cd "$start_dir"
            return 0
        else if test -f "BUILD" -o -f "BUILD.bazel"
            bazelisk test --nobuild_tests_only //...
            cd "$start_dir"
            return 0
        end

        if test -d ".git" -o (pwd) = "/"
            break
        end
        cd ..
    end
    cd "$start_dir"
    echo "Could not test, no test file found (searched for test.bash, test.sh, test, pom.xml, build.gradle, BUILD, BUILD.bazel)."
    return 1
end
