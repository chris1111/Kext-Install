# Kext-Install
- Update 10 Oct 2021 Update readme and release
- Only Apple kexts works

<p align="center">
  <img width="200" height="200" src="https://user-images.githubusercontent.com/6248794/136709606-d88b39cb-b204-469f-9d64-8c30f94c4641.png">
</p>

### Working for macOS Monterey 12 and Mac OS Big Sur 11



- Kext Install is an utility that allows you to install your kexts in 
- / System / Library / Extensions 
- Kext, bundle and plugin files are allow. No backup of the original files is made.
- Only Apple kexts can be accepted to be loaded.

### Other third party kexts files Install in /Library/Extensions ➤ use [Kext-Droplet](https://github.com/chris1111/Kext-Droplet-Big-Sur)


### Credit: chris1111 for build the app
### Credit: Base on [Jackluke](https://github.com/jacklukem) work
### Credit: [Script Debuger](https://latenightsw.com) 

- Warning: this package replaces system files and could render your system unbootable.

- To using this program SIP security (Fully disable) 
- csrutil authenticated-root disable 
- Gatekeeper must be disable

## About SIP
- authenticated-root must be disable to using the program!
### OpenCore:
- csrutil authenticated-root disable (csr-active-config ➤ EF0F0000
### Clover:
- Usage Clover csrutil authenticated-root disable (csr-active-config ➤ 0x867


### Download V1 ➤ [Kext-Install.zip](https://github.com/chris1111/Kext-Install/releases/tag/V1)

- View full Video ⬇︎

[![Modular Image Creation](https://user-images.githubusercontent.com/6248794/134072536-7c46b8cc-4d8b-42f9-a28a-3c02734f1f5d.png)](https://youtu.be/EzxwaVFHZYo)
 
##### Workaround: fix Runtime script Error, to reset full disk access privileges.
- Terminal command: ➤  tccutil reset SystemPolicyAllFiles

![Untitled](https://user-images.githubusercontent.com/6248794/123511992-d7bbbf00-d652-11eb-82c1-e9aae4c1873e.png)

- Reboot macOS then retry the program
