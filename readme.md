My HyperCube - soon to be named a super cube.

# Summary
The original HyperCube design was a good choice for my first printer. I had my brother print off the parts I needed. I ended up melting one and had my co-worker re-print it.

I didn't use the cheap electronic parts that were in the original built, instead I went all in and got some pretty nice stuff:
* <a href="https://e3d-online.com/v6-all-metal-hotend">E3D V6 hotend</a>
* <a href="https://e3d-online.com/titan-extruder">E3D Titan Extruder</a> with Compact but Powerful Motor
* <a href="https://shop.prusa3d.com/en/mk3mk3s/214-powder-coated-spring-steel-sheet.html">Prusa Spring Steel Sheet</a>
* <a href="https://www.amazon.com/dp/B07JLQW3XW">Anet A8 12-volt heat bed</a>
* <a href="https://www.amazon.com/dp/B007K2H0GI">MeanWell NES-350-12</a> volt power supply
* <a href="https://ultimachine.com/products/archim2">Archim2 controller</a>
* 2 <a href="https://ultimachine.com/products/kysan-1124090-nema-17-stepper-motor">Kysan 1124090 Nema stepper motors</a> (X/Y axis)
* <a href="https://www.amazon.com/dp/B07RRY5MYZ/">Switch/Plug combo</a>

Building it was fun. Just make sure to get the t-nuts that for the aluminum that don't require you to slide them in from the end. Lesson learned...the hard way.

Getting it to actually print was a challenge. A big challenge. Most of it had to do with the firmware. Because it's a custom printer you'll need custom firmware. Because it's the Archim2 board with a 32-bit CPU it meant using the Marlin 2.0 branch.

The example config for Archim2 did not compile because the config was wrong for the SPI and a few other things. It took about an hour or 2 to get it to actually compile and boot up on the Archim correctly. It then took another week of tinkering with it and figuring out steps per MM, correct orientation of wires, end stop modes, homing types, etc to get to it finally work correctly.

Once I got the head moving in the right directions, and the correct amounts, I ran into a weird problem. If I moved the head slowly it was accurate. Very accurate (to 1/100th of a millimeter). If it moved the head quickly, it would jump all over the place. That took a long time to figure out. It was the acceleration. Once I capped it at 500 it worked flawlessly. It prints a bit slower than I would like, but its printing perfectly. It's a work in progress.

After all of that, I got to a point where I could customize it to make it my own and better than ever.

The most annoying issue I ran into with printing on the HyperCube is the Z-Axis. There's not enough meat to the carriages that holds it up on the rods to reliably hold the gantry stable. It kept sagging after one or 2 prints. Because of that, it's the first thing I fixed. I replaced the brackets with something far more substantial and it now holds it perfectly.

After the Z-Axis fix, I print pretty well almost every time. Maybe 1 in 7 have a problem, like me forgetting to wipe off the build plate....

Now I can print, it's time to mount the electronics and make this thing safe to keep plugged in. Because right now everything is just spilled out on the table. The power cord is screwed right into the power supply with no support. And electronics are open and waiting to have screws dropped on them.

I then decided to try mounting my electronics on the back. That didn't go very far. I built a mount for the Raspberry, it's a simple thin flat piece of plastic with holes and some standoffs to hold the Pi. It worked. But I didn't like having it on the back so I didn't go much further on mounting things to the back.

I then started hunting around and came across something someone built on Thingiverse. They built a bottom storage area for the HyperCube Evolution. It wouldn't work for the original HyperCube due to size differences, but it was a starting point. Now, I'm building a base for the HyperCube using modular plates to attach whatever, wherever underneat the HyperCube.

On a side note, it enrages me that nobody posts the real source of the STL files. STL files are NOT source. Sure you could change them. But it's akin to opening a hex editor and modifying a binary file. So, I'm sharing my SCAD files under the MIT license, like I do with everything else I put out there for people to use.

# Things I changed
## Z Axis (the part that goes up and down)
The first thing I really didn't like was the Z axis and the way it was mounted. It was extremely unstable and wouldn't stay level because of it. I was also unable to keep it square/level on both sides.

 Even after moving the sliding rods to the sides (which helped a lot), the mounts were just to small. So I rebuilt those.
 
 They are longer and a bit more beefy. They now go underneath the arms to prevent them from sagging. This added a huge amount of stability and so far the only time I have to level the bed is when I push down really hard or change something on the bed platform itself.

 ## Extruder (the part the pushes the filament)
 The second thing was the extruder, I wanted something nicer so I ended up getting an E3D Titan extruder and building a mount for it.

 The differences in prints between using a simple extruder and something with a .9&deg; step and a 3:1 reducing gear was insane. I can't believe how much better the prints are coming out.

# Things I've added
## Rear Electronics Mounts (not used anymore)
| Part | File |
|-|-|
| Raspberry Pi | <a href="Electronics Bay\Rear Mounted\PiMount\Pi Mount.scad">Electronics Bay\Rear Mounted\PiMount\Pi Mount.scad |

## Bottom electronics bay
An area underneath the printer to mount the electronics (plates) and a drawer to hold tools and other non-sense (coming soon)
<a href="Electronics Bay/Bottom Mounted">Electronics Bay/Bottom Mounted</a>

* Corner brackets to sit the printer on and mount plates to <a href="Electronics Bay/Bottom Mounted/Corner Stand.scad">Corner Stand.scad</a>
* A plate to hold the Raspberry Pi <a href="Electronics Bay/Bottom Mounted/PI Mount Combined.scad">PI Mount Combined.scad</a>
* A plate to put a switch and plug in to <a href="Electronics Bay/Bottom Mounted/Switch Plate.scad">Switch Plate.scad</a>
* Plates for the NES-350-12 power supply (coming soon)
* A plate for the Archim2 controller board (coming soon)