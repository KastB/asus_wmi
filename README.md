# asus-wmi
Quickstart
----------

- **Build** -  run ```make``` inside the directory
- **Install** - first save the original modules by moving them to a save place (search for  "asus-nb-wmi.ko.gz"  and "asus-wmi.ko.gz")
run ```sudo make install``` inside the directory 
- **Load** 
```bash
sudo modprobe asus-nb-wmi
```

- **Interface**  the fan(s) is/are exposed as  a hwmon interface, thus available in:

```bash
/sys/class/hwmon/hwmonX
```
- **Monitor Fan speed** -simply use xsensors for graphical, or sensors for console monitoring


- **Set Fan Speed** - write anything from 0 to 255 to ```pwmX```, like:
```bash
sudo tee /sys/class/hwmon/hwmonX/pwm1 <<< 123   # set to 123
sudo tee /sys/class/hwmon/hwmonX/pwm1 <<< 0     # switch fan off (DANGEROUS!)
sudo tee /sys/class/hwmon/hwmonX/pwm1 <<< 255   # set to max speed
```
- **ATTENTION** - the fan is now in manual mode - do not burn your machine!
- **Set Auto-Fan(s)**: to reactivate the automatic fan control write "0" or "2" to ```pwmX_enable```:
```bash
sudo tee /sys/class/hwmon/hwmonX/pwm1_enable <<< 2  # reset to auto-mode (always for all fans)
```

- **fancontrol** - There is a script called "fancontrol" that can be configured according to temperature source, fans to 
control, minimum and maximum temperature...
thats done by "pwmconfig"
Nevertheless that script did it worse for me than the original controller - thus you can tell it to stop the fan completely...

- **Tested**
-------------

Single Fan | Two Fans (NVIDIA)
-----------|-------------------
N551JK     |  UX32VD

- **Features**
---------
- reading and setting fan speed(s)
- no memory corruption (opposed to Felipe Contreras https://lkml.org/lkml/2013/10/8/800 patch)
- using wmi interface
- but still using virt_to_phys - nevertheless there is a ACPI function that is just marked "ACPI_FUTURE_USAGE" in "/drivers/acpi/osl.c#L37" thus after testing this module we could try to get that define to be deleted
- quiet mode not implemented by now (maximum speed for fans in auto and manual mode)
- no dual-fan support