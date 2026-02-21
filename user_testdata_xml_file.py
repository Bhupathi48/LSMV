# update_xml_library.py
import xml.etree.ElementTree as ET
import re
import random

def update_dollar_replace_in_extensions(xml_file, new_value, dest_file=None):
    """
    Replace any occurrence of '${Replace}' in the extension attribute of <id> tags with the new value, preserving the rest of the extension value.
    Writes the updated XML to dest_file if provided, otherwise overwrites the original file.
    Args:
        xml_file (str): Path to the XML file.
        new_value (str): The value to replace '${Replace}' with.
        dest_file (str, optional): Path to write the updated XML. If None, overwrites xml_file.
    """
    with open(xml_file, 'r', encoding='utf-8') as f:
        xml_content = f.read()
    pattern = r'(extension="[^"]*)\$\{Replace\}([^\"]*")'
    def replacer(match):
        before = match.group(1)
        after = match.group(2)
        return f'{before}{new_value}{after}'
    new_content, count = re.subn(pattern, replacer, xml_content)
    if count == 0:
        print("No '${Replace}' extensions found to update.")
    else:
        output_path = dest_file if dest_file else xml_file
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {count} '${{Replace}}' extensions in {output_path}.")


def update_xml_in_robot(xml_file, dest_file=None):
    """
    Wrapper function to generate a random three-digit number and call update_dollar_replace_in_extensions.
    Args:
        xml_file (str): Path to the XML file.
        dest_file (str, optional): Path to write the updated XML. If None, overwrites xml_file.
    """
    random_number = str(random.randint(1000, 9999))
    print(f"Generated random number: {random_number}")
    print("xml file is ", xml_file)
    print("dest file is ", dest_file)
    update_dollar_replace_in_extensions(xml_file, random_number, dest_file)

# update_dollar_replace_in_extensions(
#     "C:/Users/PSomavar/Documents/lsmv_updated/lsmv_automation_poc/LSMV/Tests/Web/POC/xmlfile.xml",
#     random_number,
#     "C:/Users/PSomavar/Documents/lsmv_updated/lsmv_automation_poc/LSMV/Tests/Web/POC/testdata_xml_file/xmlfile_updated.xml"
# )
# update_xml_in_robot(
# "C:/Users/PSomavar/Documents/lsmv_updated/lsmv_automation_poc/LSMV/Tests/Web/POC/testdata_xml_file/xmlfile.xml",
# "C:/Users/PSomavar/Documents/lsmv_updated/lsmv_automation_poc/LSMV/Tests/Web/POC/testdata_xml_file/xmlfile_updated.xml"
# )

def update_messagenumb_in_robot(xml_file, dest_file=None):
    """
    Wrapper function to generate a random value and call update_messagenumb_in_xml.
    Args:
        xml_file (str): Path to the XML file.
        dest_file (str, optional): Path to write the updated XML. If None, overwrites xml_file.
    """
    print("xml file is ", xml_file)
    print("dest file is ", dest_file)
    update_messagenumb_last_two_digits(xml_file, dest_file)

def update_messagenumb_last_two_digits(xml_file, dest_file=None):
    """
    Replace the last three characters (one letter + two digits) inside <messagenumb> tags with random values.
    Pattern: Random letter (A-Z) + Random two-digit number (10-99). Example: S49 becomes A73.
    Writes the updated XML to dest_file if provided, otherwise overwrites the original file.
    Args:
        xml_file (str): Path to the XML file.
        dest_file (str, optional): Path to write the updated XML. If None, overwrites xml_file.
    """
    import re, random, string
    with open(xml_file, 'r', encoding='utf-8') as f:
        xml_content = f.read()
    # Match <messagenumb>...</messagenumb> and replace last three characters (letter + two digits)
    pattern = r'(<messagenumb>)(.*?)([A-Za-z])(\d{2})(</messagenumb>)'
    def replacer(match):
        prefix = match.group(1)
        main_part = match.group(2)
        new_letter = random.choice(string.ascii_uppercase)
        new_two_digits = f"{random.randint(10,99):02d}"
        suffix = match.group(5)
        return f"{prefix}{main_part}{new_letter}{new_two_digits}{suffix}"
    new_content, count = re.subn(pattern, replacer, xml_content)
    if count == 0:
        print("No <messagenumb> tags found to update.")
    else:
        output_path = dest_file if dest_file else xml_file
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {count} <messagenumb> tag(s) in {output_path}.")

