function t -d "Test code in current or parent directory (using various strategies)"
  set DIR $PWD

  if test -x $DIR/test*
    $DIR/test*
  else if test -x $DIR/pom.xml
    $DIR/mvnw test
  else if test -x $DIR/build.gradle
    $DIR/gradlew test
  else if test -x $DIR/BUILD*
    bazelisk test --nobuild_tests_only //...
  else
    # TODO Implement logic to walk up parent directories...
    echo "Could not test, no $DIR/test.bash"
  end
end
