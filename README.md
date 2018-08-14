# NOTICE: THIS SCRIPT WILL BE INCOMPATIBLE WITH 0.7.0 :(

# tes3mp-playercells

This gives mods the ability to give players their on cells, where they can whitelist and unwhitelist it, and add whitelisted people. It was made afterplayer-ran stores would get robbed when players were offline.

# How to use


Admin & Mods:
  
  /registerCell <pid>

Call this when the player is in the cell he desires

Users:

  /addcellmember <pid>

Add a whitelisted member to your cell who can enter when it's locked

  /removeCellMember <pid>
  
Remove a whitelisted member from your cell

  /lock & /unlock
  
Make your cell locked/unlocked from people not whitelisted, if they try to enter they will be redirected back (Make sure you are in your own cell when locking)

# How to install


Put "playercells.json" in mp-stuff/data or corescripts/data

Put snippets of code in playercells.lua in their respective places in server.lua in mp-stuff/scripts or corescripts/data (Read Comments)
