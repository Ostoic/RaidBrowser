# RaidBrowser
A Raid Browser/Finder Addon for World of Warcraft 3.3.5a

RaidBrowser searches for LFM messages sent in all chat channels and lists found raids in Blizzard's 
LFR raid browser, which is unused in patch 3.3.5a. 

# Features

- Easily find raids hosted by other players by searching for "LFM barks" in global/trade/any chat channels. Raids are listed along with the required roles, and the minimum gearscore requirement, if any were mentioned in the message.
- Identifies saved raids by coloring their name as red for locked raids, and green for unsaved raids.
- Join / Double click: After clicking on an entry in the raid browser, send a formatted message to the raid host with your GS, class, spec, and highest achievement obtained for that raid.
- Tooltip Hover: Hovering your mouse over an entry in the raid browser shows the original chat message, as well as how long it's been since the message was sent.
- Raid hosts that do not send a message after 1-2 minutes will have their entry expire in the raid browser. This ensures that the raid browser does not become cluttered.
- Create primary and secondary raid sets (Ex: Elemental 5641gs) for use in join messages. In the given example, your message will be formatted in a manner similar to "inv 5641gs Elemental Shaman <possible achievement link>". If you are pvping in WG while searching for raids, the addon will send information from the currently selected raidset to the raid host instead of your pvp (spec, gs).

# Installation and Usage
As with any other addon, copy the RaidBrowser folder into your %WoW Root%/Interface/AddOns directory. When ingame, type /rb to activate
the raid browser UI. Alternatively, the interface can be accessed as follows:
1. Open the social menu,
2. Select the raid tab,
3. Click "Raid Browser"

![alt text](https://i.imgur.com/dR7MIUf.png)
![alt text](https://i.imgur.com/qkVS07w.png)
![alt text](https://i.gyazo.com/c0ff4ffb319e2c88c1c03a1124ddec98.mp4)

# Todo
- Add more raids and achievements. Icc, toc, naxx, rs, ulduar, and os are currently the only supported raids.
- Further improve pattern matching for better detection of LFM messages.
- Sort raid entries by gs/name/etc
- Raid host tab where "Inv x gs [achieve]" messages are parsed similarly to how LFM messages are parsed. Can select raid to host, GS min req, achievement requirement, etc which will be formatted into an auto-barked message sent to the specified channel.
- If you run into any bugs, such as incorrect information being reported by the addon, send me a screenshot/copy of the original message and the incorrect information the addon displayed.
- Suggestions?? Open up an issue or send me a message ingame/in discord.

# Remark

Be aware that since it is difficult to consider every possible LFM message that someone could think of, this addon may consider false 
positives, or may omit valid LFM messages. As an example, some guild recruitment messages may be listed in the raid browser, since a lot of the language used in these messages is similar to LFM messages. On the other hand, a raid host may use unexcepted words or grammar in his LFM message.

# Acknowledgements
Thanks to the following people for feature ideas and bug reports:
- Adidi
- Swenson
- Imbued


