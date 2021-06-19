# RaidBrowser
Bringing LFR to Wotlk.

This addon replaces the unused (in 3.3.5a) LFR tab in the social menu with a working raid finder. RaidBrowser works similarly to Live WoW's group finder, except raid leaders do not need to interact with the addon to list their group. RaidBrowser searches for LFR messages sent in chat and /y channels and lists any found raids in the "Browse" tab of the raid browser. 

When searching for a raid to join in Global, there can be large amounts of text (and meaningless spam) to read in order find anything. This addon does all the text processing work and lists all the raids in a coherent format. Each entry in the raid browser is formatted as follows to include raid leader name, raid name, gearscore requirements, and the list of needed roles (tank/healer/dps).

![alt text](https://i.imgur.com/6aqE1TD.png)

No longer will you join a raid and embarrass yourself upon realizing that you've already been locked into that raid for the week. RaidBrowser clearly highlights locked raids in red (e.g. ![alt text](https://i.imgur.com/hvTL7s8.png) ). Any raids for which you are not saved are marked in bright green (e.g. ![alt text](https://i.imgur.com/5SkqcwA.png) ). Thus, you will know beforehand whether you should ignore that raid or not.

# Features

- Easily find raids hosted by other players by searching for "LFM barks" in global/trade/any chat channels. Raids are listed along with the required roles, and the minimum gearscore requirement, if any were mentioned in the message.
- Identifies saved raids by coloring their name as red for locked raids, and green for unsaved raids.
- Join / Double click: After clicking on an entry in the raid browser, send a formatted message to the raid host with your GS, class, spec, and highest achievement obtained for that raid.
- Tooltip Hover: Hovering your mouse over an entry in the raid browser shows the original chat message, as well as how long it's been since the message was sent.
- Create primary and secondary raid sets (Ex: Elemental 5641gs) for use in join messages. In the given example, your message will be formatted in a manner similar to "inv 5641gs Elemental Shaman <possible achievement link>". If you are pvping in WG while searching for raids, the addon will send information from the currently selected raidset to the raid host instead of your pvp (spec, gs).
- Raid hosts that do not send a message after 1-2 minutes will have their entry expire in the raid browser. This ensures that the raid browser does not become cluttered.
  
# How to Download

In order to download the latest stable version, click on "releases" which is in the repository statistics tab under the addon description (example: https://github.com/Ostoic/RaidBrowser/releases/latest). The .zip file is the addon folder, so make sure you unzip that folder to one named "RaidBrowser", then follow the instructions below.

# Installation and Usage
As with any other addon, copy the RaidBrowser folder into your %WoW Folder%/Interface/AddOns directory. 
When ingame, type /rb to activate the raid browser UI. Alternatively, the interface can be accessed as follows:
1. Open the social menu (Press O),
2. Select the "Raid" tab,
3. Click "Open Raid Browser"

It is important to join the global channel in order for the addon to find raids. If you don't want your chat window to be filled with global chatter, you can simply hide the global channel from your default chat window. 

1. Right click the "General" tab
2. Click settings (under Filters)
3. Select the Global Channels tab
4. Make sure "global" is unchecked in the list of channels.

Now RaidBrowser will be able to find raids without having global being dumped into the General chat window.

See the common issues section for further help.

# Examples 
![alt text](https://i.imgur.com/dR7MIUf.png)
![alt text](https://i.imgur.com/qkVS07w.png)
![alt text](https://i.imgur.com/GvEgQSJ.gif)

# Common Issues
**Improper Addon Placement**

A fairly common issue when unzipping the addon is that your zip program puts the addon at RaidBrowser/RaidBrowser. Make sure that when you open the folder in the Addons directory (in %WoW Folder%/Interface/AddOns), you see all the .lua files (core.lua, RaidBrowser.toc, etc). Make sure you can see RaidBrowser.toc by going to %WoW Folder%/Interface/AddOns/RaidBrowser/RaidBrowser.toc.

# Todo
- Add more raids and achievements. Icc, toc, naxx, rs, ulduar, and os are currently the only supported raids.
- Further improve pattern matching for better detection of LFM messages.
- Sort raid entries by gs/name/etc
- Raid host tab where "Inv x gs [achieve]" messages are parsed similarly to how LFM messages are parsed. Can select raid to host, GS min req, achievement requirement, etc which will be formatted into an auto-barked message sent to the specified channel.
- If you run into any bugs, such as incorrect information being reported by the addon, send me a screenshot/copy of the original message and the incorrect information the addon displayed.
- Suggestions?? Open up an issue or send me a message ingame/in discord.

# Remark

Be aware that since it is difficult to consider every possible LFM message that someone could think of, this addon may consider false 
positives, or may omit valid LFM messages. As an example, some guild recruitment messages may be listed in the raid browser, since a lot of the language used in these messages is similar to LFM messages. On the other hand, a raid host may use unexpected words or grammar in their LFM message.

# Acknowledgements
Thanks to the following people for feature ideas and bug reports:
- Adidi
- Swenson
- Imbued

Support Me: 83RC32Rk2BuhLHA9MWmeheXPkNLYLervNQW3ce3zrGoq6sZsdpjoa5vBbt2sBxrpboPjiqkXd4AjTeGR6E2HEcNNNdxtPCR (XMR)
