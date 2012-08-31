#!/bin/bash

# Import Environment Variables
for f in ~/.env/*
do
    . $f
done

if [ -z "$BUILD_NUMBER" ]
then
  USED_BUNDLER=false
  if [ -d ${OPENSHIFT_RUBY19_TMP_DIR}/.bundle ]
  then
    USED_BUNDLER=true
  fi

  if $USED_BUNDLER
  then
    echo 'Restoring previously bundled RubyGems (note: you can commit .openshift/markers/force_clean_build at the root of your repo to force a clean bundle)'
    mv ${OPENSHIFT_RUBY19_TMP_DIR}/.bundle ${OPENSHIFT_REPO_DIR}
    if [ -d ${OPENSHIFT_REPO_DIR}vendor ]
    then
      mv ${OPENSHIFT_RUBY19_TMP_DIR}/vendor/bundle ${OPENSHIFT_REPO_DIR}vendor/
    else
      mv ${OPENSHIFT_RUBY19_TMP_DIR}/vendor ${OPENSHIFT_REPO_DIR}
    fi
    rm -rf ${OPENSHIFT_RUBY19_TMP_DIR}/.bundle ${OPENSHIFT_RUBY19_TMP_DIR}/vendor
  fi
  
  # If .bundle isn't currently committed and a Gemfile is then bundle install
  if [ -f ${OPENSHIFT_REPO_DIR}Gemfile ]
  then
      if ! git show master:.bundle > /dev/null 2>&1
      then
          echo "Bundling RubyGems based on Gemfile/Gemfile.lock to repo/vendor/bundle with 'bundle install --deployment'"
          SAVED_GIT_DIR=$GIT_DIR
          unset GIT_DIR
          pushd ${OPENSHIFT_REPO_DIR} > /dev/null
          /usr/bin/scl enable ruby193 "bundle install --deployment"
          popd > /dev/null
          export GIT_DIR=$SAVED_GIT_DIR
      fi
      echo "Precompiling with 'bundle exec rake assets:precompile'"
      pushd ${OPENSHIFT_REPO_DIR} > /dev/null
      /usr/bin/scl enable ruby193 "bundle exec rake assets:precompile" 2>/dev/null
      popd > /dev/null
  fi

fi

/usr/bin/scl enable ruby193 "user_build.sh"
