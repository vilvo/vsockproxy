use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 4 {
        eprintln!("usage: vsockproxy <local_port> <remote_cid> <remote_port>");
        std::process::exit(1);
    }
    // Disable stdout buffering so that journald can show live data
    // TODO:
    // https://docs.rs/rs-streams/latest/rs_streams/fn.setvbuf.html

    let local_port: i32 = args[1].parse::<i32>().unwrap();
    let remote_cid: i32 = args[2].parse::<i32>().unwrap();
    let remote_port: i32 = args[3].parse::<i32>().unwrap();
    println!("vsockproxy started (local port {}, remote cid {}, remote port {})",
             local_port, remote_cid, remote_port);
}
