mvn --settings /Users/mikebyls/ws/galasa/ZZZ_Maven/settings.xml -P dev -B -e clean
mvn --settings /Users/mikebyls/ws/galasa/ZZZ_Maven/settings.xml -P dev -B -e -f pom2.xml process-resources
mvn --settings /Users/mikebyls/ws/galasa/ZZZ_Maven/settings.xml -P dev -B -e -f pom3.xml process-resources
mvn --settings /Users/mikebyls/ws/galasa/ZZZ_Maven/settings.xml -P dev -B -e -f pom4.xml process-resources
mvn --settings /Users/mikebyls/ws/galasa/ZZZ_Maven/settings.xml -P dev -B -e install
cp -v target/galasa-isolated-mvp-maven-repo-0.15.0-SNAPSHOT-repo.zip ~/webserver/repo.zip
