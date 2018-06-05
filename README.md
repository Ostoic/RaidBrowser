# RaidBrowser
A Raid Browser Addon for World of Warcraft 3.3.5a

The addon parses LFM messages sent in any chat channels the player is currently in. Any found raids will be listed in Blizzard's 
LFR raid browser, which is unused in patch 3.3.5a. 

# Features

- Easily find raids hosted by other players by searching for "LFM barks" in global/trade/any chat channels. Raids are listed along with the required roles, and the minimum gearscore requirement, if any were mentioned in the message.
- Join / Double click: After clicking on an entry in the raid browser, send a formatted message to the raid host with your GS, class and spec.
- Tooltip Hover: Hovering your mouse over an entry in the raid browser shows the original chat message, as well as how long it's been since the message was sent.
- Raid hosts that do not send a message after 1-2 minutes will have their entry expire in the raid browser. This ensures that the raid browser does not become cluttered.
- Low memory usage: Since the UI and icons are already loaded ingame, not much extra memory is needed (30-60 KB).

![alt text](https://i.imgur.com/lgnYIpN.png)

# Installation
As with any other addon, copy the RaidBrowser folder into your %WoW Root%/Interface/AddOns directory. Nothing more is required.

# Todo
- Detect the highest-achieved achievement for the given raid and link it for the associated join message to send to the raid host.
- Suggestions?? Open up an issue!

# Remark

Be aware that since it is difficult to consider every possible LFM message that someone could think of, this addon may consider false 
positives, or may omit valid LFM messages. For example, I recently saw someone hosting an icc 25 in which they wrote icc 25 as 
ICC-25-man. If you encounter any such problems open up an issue describing the bug and how it the addon should behave in said context,
if you're so inclined.
