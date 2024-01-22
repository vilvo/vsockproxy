use assert_cmd::prelude::*;
use predicates::prelude::*;
use std::process::Command;

// s/debug/release/ for release testing
static PROGRAM_TO_TEST: &str = "target/debug/vsockproxy";

#[test]
fn test_no_args() -> Result<(), Box<dyn std::error::Error>> {
    let mut cmd = Command::new(PROGRAM_TO_TEST);
    cmd.assert()
        .failure()
        .stderr(predicate::str::contains("usage: vsockproxy"));
    Ok(())
}

// a minimal test - but only adequate. TODO: Relevant port and CID ranges
#[test]
fn test_valid_args() -> Result<(), Box<dyn std::error::Error>> {
    let mut cmd = Command::new(PROGRAM_TO_TEST);
    cmd.arg("1").arg("2").arg("3");
    cmd.assert().success();
    Ok(())
}

// should not panic - but for C-impl. compliance in the baseline
#[test]
fn test_invalid_args() -> Result<(), Box<dyn std::error::Error>> {
    let mut cmd = Command::new(PROGRAM_TO_TEST);
    cmd.arg("a").arg("b").arg("c");
    cmd.assert()
        .failure()
        .stderr(predicate::str::contains("proper error handling"));
    Ok(())
}
