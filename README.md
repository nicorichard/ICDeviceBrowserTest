# ICDeviceBrowserTest

Minimal reproducible example of a potential iOS 18 (beta) bug preventing ICDeviceBrowser authorization

![image](https://github.com/nicorichard/ICDeviceBrowserTest/assets/3505591/288db1d8-d350-4871-a71f-f507d2940d0a)

### Findings

When attempting to authenticate the following logs are produced:

```
[0x152904db0] activating connection: mach=false listener=false peer=false name=com.apple.icprefd-xpc
[0x152904db0] failed to do a bootstrap look-up: xpc_error=[3: No such process]
[0x152904db0] invalidated after a failed init
```
