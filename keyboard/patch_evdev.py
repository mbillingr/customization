import shutil
import xml.etree.ElementTree as ET

EVDEV = "/usr/share/X11/xkb/rules/evdev.xml"

tree = ET.parse(EVDEV)

layouts = tree.getroot().find("layoutList").findall("layout")

layout_us = next(l for l in layouts if l.find("configItem").find("name").text == "us")

variants = layout_us.find("variantList").findall("variant")
if any(v.find("configItem").find("name").text == "dpe" for v in variants):
    print("DPE already in evdev")
else:
    name = ET.Element("name")
    name.text = "dpe"
    desc = ET.Element("description")
    desc.text = "English (Programmer Dvorak Eur. Keys)"
    cfg_item = ET.Element("configItem")
    cfg_item.append(name)
    cfg_item.append(desc)
    variant_dpe = ET.Element("variant")
    variant_dpe.append(cfg_item)

    layout_us.find("variantList").insert(0, variant_dpe)

    shutil.copyfile(EVDEV, EVDEV + ".backup")
    tree.write(EVDEV)

