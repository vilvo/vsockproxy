use std::env;
use vsock::{VsockAddr, VsockListener};
use libc::VMADDR_CID_ANY;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 4 {
        eprintln!("usage: vsockproxy <local_port> <remote_cid> <remote_port>");
        std::process::exit(1);
    }
    // Disable stdout buffering so that journald can show live data
    // TODO:
    // https://docs.rs/rs-streams/latest/rs_streams/fn.setvbuf.html

    let local_port: u32 = args[1].parse::<u32>().unwrap();
    let remote_cid: u32 = args[2].parse::<u32>().unwrap();
    let remote_port: u32 = args[3].parse::<u32>().unwrap();
    println!(
        "vsockproxy started (local port {}, remote cid {}, remote port {})",
        local_port, remote_cid, remote_port
    );

    let listener_result = VsockListener::bind(&VsockAddr::new(VMADDR_CID_ANY, local_port));
    let listener = match listener_result {
        Ok(listener) => listener,
        Err(error) => {
            eprintln!("bind and listen failed: {}", error);
            std::process::exit(1);
        }
    };

    let nonblocking_result = listener.set_nonblocking(true);
    let _ = match nonblocking_result {
        Err(error) => {
            eprintln!("Failed to set non block {}", error);
            std::process::exit(1);
        }
        _ => (),
    };
}
