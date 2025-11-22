#import "@preview/cetz:0.4.2"
= The 4 Layer Internet Model
// the picture of the 4 layer internet model with descriptions of each layer
#cetz.canvas({
  import cetz.draw: *
  rect((0, 0), (3, 1), fill: gray, name: "link")
  content("link", "Link")
  content("link.south-east", anchor: "base-west", block(
    width: 25em,
    inset: (left: 0.5em, bottom: 0.3em),
    stroke: (bottom: (dash: "dashed")),
    "Delivers data over a single link between an end host and router, or between routers",
  ))
  rect((0, 1), (3, 2), fill: yellow, name: "internet")
  content("internet", "Internet")
  content("internet.south-east", anchor: "base-west", block(
    width: 25em,
    inset: (left: 0.5em, bottom: 0.3em),
    stroke: (bottom: (dash: "dashed")),
    "Delivers datagrams end-to-end. Best-effort delivery - no grantees. Must use the Internet Protocol (IP)",
  ))
  rect((0, 2), (3, 3), fill: green, name: "transport")
  content("transport", "Transport")
  content("transport.south-east", anchor: "base-west", block(
    width: 25em,
    inset: (left: 0.5em, bottom: 0.3em),
    stroke: (bottom: (dash: "dashed")),
    "Guarantees correct, in-order delivery of data end-to-end. Controls congestion.",
  ))
  rect((0, 3), (3, 4), fill: blue, name: "application")
  content("application", "Application")
  content("application.south-east", anchor: "base-west", block(
    width: 25em,
    inset: (left: 0.5em, bottom: 0.4em),
    stroke: (bottom: (dash: "dashed")),
    "Bi-directional reliable byte stream between two applictions, using application-specifc semantics(e.g. http, bit-torrent).",
  ))
})
== Three principle
=== packet switching
#list(
  marker: [],
  [*Packet*: A Self-contained unit of data that carries information necessary for it to reach its destionation.],
  [*Packet switching*: Independently for each arriving packet, pick its outgoing link. If the link is free, send it. Else hold the packet for later.],
)
=== Layering
=== Encapsulation
= IP 
== The IP Service Model
#table(
  columns:(auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(table.cell([*Property*],align: center),table.cell([*Behavior*],align: center)),
  table.cell(text("Datagram",weight: "bold",fill: blue),align: center),
  "Individually routed packets. Hop-by-hop routing.",
  table.cell(text("Unreliable",fill: blue,weight: "bold"),align: center),
  "Packets might be dropped.",
  table.cell(text("Best-effort",fill: blue,weight: "bold"),align: center),
  "...but only if necessary.",
  table.cell(text("Connectionless",fill: blue,weight: "bold"),align: center),
  "No per-flow state. Packets might be mis-sequenced."
)
== Why is the IP service so simple?
- Simple, dumb, minimal: Faster, more streamlined and lower cost to build and maintain.
- The end-to-end principle: Where possible, implement features in the end hosts.
- Allows a variety of reliable (or unreliable) services to be built on top.
- Works over any link layer: IP makes very fews assumptions about the layer below.
== The IP Services Model (Details)
+ Tries to prevent packets looping forever.
+ Will fragment packets if they are too long.
+ Uses a header checksum to reduce chances of delivering datagram to wrong destination.
+ Allows for new versions of IP 
  #list(marker: [--],
    [Currently IPv4 with 32 bit addresses],
    [And IPv6 with 128 bit addresses]
  )
+ Allows for options to be added to header.
== Byte Order
#cetz.canvas(
  {
     import cetz.draw: *
     group({
      grid((0,0),(4,0.5),step:(2,0.5))
      content((1,0.25),[*?*])
      content((3,0.25),[*?*])
     },name:"result")
     content("result.west",box([*1,024 = 0x0400 =*],inset: 0.5em),anchor: "mid-east",)

  }
)
- Multibyte words: how do you arrange the bytes?
- Litte endian: least significant byte is at lowest address 
 - Makes most semse from an addressing/computational standpoint
  #cetz.canvas({
  import cetz.draw: *
  rect((0,0),(2,0.5),name: "1")
  rect((2,0),(4,0.5),name: "2")
  content("1.center",[*0x00*])
  content("2.center",[*0x04*])
 })
- Big endian: most significant byte is at lowest address
 - Makes most sense to a human reader
  #cetz.canvas({
    import cetz.draw: *
    rect((0,0),(2,0.5),name: "1")
    rect((2,0),(4,0.5),name: "2")
    content("1.center",[*0x04*])
    content("2.center",[*0x00*])
  })
== Packets Formats
```
0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|Version|  IHL  |Type of Service|           Total Length      |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|          Identification       |Flags  |   Fragment Offset   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|     TTL       |    Protocol   |      Header Checksum        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                       Source Address                        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                     Destination Address                     |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Options                    |   Padding   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
Version: IP version, e.g., IPv4 = 4, IPv6 = 6
IHL: Internet Header Length
TTL: Time To Live
Protocol: Protocol ID, e.g., TCP = 6, UDP = 17
Identification, Flags, Fragment Offset: Used for fragmentation/reassembly
```