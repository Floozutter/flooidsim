fn run() -> Result<(), Box<dyn std::error::Error>> {
    use std::io::Write;
    let imidi = midir::MidiInput::new("midi-chaos midir input")?;
    // get an input port (read from console if multiple are available)
    let iports = imidi.ports();
    let iport = match iports.len() {
        0 => return Err("no available input port found".into()),
        1 => {
            println!("only available input port: {}", imidi.port_name(&iports[0]).unwrap());
            &iports[0]
        },
        _ => {
            println!("available input ports:");
            for (i, p) in iports.iter().enumerate() {
                println!("{}: {}", i, imidi.port_name(p).unwrap());
            }
            print!("select input port: ");
            std::io::stdout().flush()?;
            let mut input = String::new();
            std::io::stdin().read_line(&mut input)?;
            iports.get(input.trim().parse::<usize>()?).ok_or("invalid input port selected")?
        }
    };
    println!("\nopening connection...");
    let iport_name = imidi.port_name(iport)?;
    // _connection needs to be named to keep it alive
    let _connection = imidi.connect(iport, "midi-chaos_iport", move |stamp, message, _| {
        println!("{}: {:?} (len = {})", stamp, message, message.len());
    }, ())?;
    println!("connection open, reading input from `{}`...", iport_name);
    // quit on enter key press
    print!("press enter at any point to quit.");
    std::io::stdout().flush()?;
    {
        let mut input = String::new();
        std::io::stdin().read_line(&mut input)?;
    }
    println!("bye-bye! >:3c");
    Ok(())
}

fn main() {
    match run() {
        Ok(_) => (),
        Err(err) => eprintln!("error: {}!", err)
    }
}
