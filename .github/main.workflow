workflow "Build and test" {
  on = "push"
  resolves = ["Test-5.6", "Test-7.0", "Test-7.1", "Test-7.2", "Test-7.3"]
}

action "Test-5.6" {
  uses = "./.github/actions/buildtest-action"
  env = {
    VERSION = "5.6"
  }
}

action "Test-7.0" {
  uses = "./.github/actions/buildtest-action"
  env = {
    VERSION = "7.0"
  }
}

action "Test-7.1" {
  uses = "./.github/actions/buildtest-action"
  env = {
    VERSION = "7.1"
  }
}

action "Test-7.2" {
  uses = "./.github/actions/buildtest-action"
  env = {
    VERSION = "7.2"
  }
}

action "Test-7.3" {
  uses = "./.github/actions/buildtest-action"
  env = {
    VERSION = "7.3"
  }
}
