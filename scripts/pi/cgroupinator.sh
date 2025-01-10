#!/bin/sh
## enables CGroups on Raspberry Pi SoCs.


grep -q 'cgroup_enable=memory' /boot/firmware/cmdline.txt || sudo sed -i '$ s/$/ cgroup_memory=1 cgroup_enable=memory/' /boot/firmware/cmdline.txt && echo "Update complete. Reboot to apply changes."
