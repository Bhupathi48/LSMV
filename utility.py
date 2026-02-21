import re
from datetime import datetime, timedelta
import platform

def get_test_execution_environment():
    """
    Determines the test execution environment based on the operating system.
    :return: 'local' if running on Windows, 'ci' otherwise
    """
    platform_name = platform.system().lower()
    if 'windows' in platform_name:
        return 'local'
    else:
        return 'linux'
      

def extract_rct_number(text):
    match = re.search(r'RCT\d+', text)
    if match:
        return match.group()
    return None

# print(extract_rct_number("INFO :Case created successfully : RCT20250036083"))  # Output: RCT20250036083

def check_string_in_string(string, substring):
    return substring in string

def convert_comma_separated_string_to_list(comma_separated_string):
    # return [item.strip() for item in comma_separated_string.split(',') if item.strip()]
    item = str(comma_separated_string)
    item = item.split(',')
    return [i.strip() for i in item if i.strip()]


print(convert_comma_separated_string_to_list('10051118, 10053762'))  # Output: ['apple', 'banana', 'cherry']

def fetch_date_by_expected_days_from_today(days, date_format="%d-%m-%Y"):
    if days == "current date":
        return datetime.now().strftime(date_format)   
    days = int(days) 
    target_date = datetime.now() + timedelta(days=days)
    return target_date.strftime(date_format)

# print(fetch_date_by_expected_days_from_today("current date"))  # Output: Current date in "dd-mm-yyyy" format

def calculate_date_difference_in_weeks(start_date, end_date, date_format="%d-%m-%Y"):
    """Calculate Gestational Age At Event in weeks per application requirements.

    Requirements:
    1. The Gestational Age At Event should be calculated as the difference between 
       Earliest Onset Date of the event and (LMP Of Parent + 14 days) divided by 7
    2. If the calculated Gestational Age At Event is not multiples of 7 then set it to latest week:
       - If calculated value is between 1-7 days → set to 1 week
       - If calculated value is between 8-14 days → set to 2 weeks  
       - If calculated value is between 15-21 days → set to 3 weeks, and so on

    Args:
        start_date (str): LMP Of Parent date string in the given format.
        end_date (str): Earliest Onset Date string in the given format.
        date_format (str): Format for parsing dates. Default "%d-%m-%Y".

    Returns:
        int: Gestational Age At Event in weeks (rounded up to latest week) or 0 if invalid.
    """
    try:
        d_start = datetime.strptime(start_date, date_format)
        d_end = datetime.strptime(end_date, date_format)
    except ValueError:
        # If parsing fails, return 0 as safe default
        return 0

    # Add 14-day offset to LMP date (reference date)
    reference_date = d_start + timedelta(days=14)
    day_diff = (d_end - reference_date).days  # integer day difference

    if day_diff <= 0:
        return 0

    # Calculate weeks using ceiling division to round to latest week
    # If days 1-7 → week 1, days 8-14 → week 2, days 15-21 → week 3, etc.
    weeks = (day_diff + 6) // 7
    return weeks

# print(calculate_date_difference_in_weeks("01-03-2024", "30-03-2024"))

from datetime import datetime

def convert_date_format(date_string):
    """
    Convert date from DD-MM-YYYY format to DD-Mon-YYYY format
    
    Args:
        date_string (str): Date in format "DD-MM-YYYY" (e.g., "03-11-2025")
    
    Returns:
        str: Date in format "DD-Mon-YYYY" (e.g., "03-Nov-2025")
    
    Example:
        >>> convert_date_format("03-11-2025")
        '03-Nov-2025'
    """
    try:
        # Parse the input date string
        date_obj = datetime.strptime(date_string, "%d-%m-%Y")
        
        # Format to desired output
        formatted_date = date_obj.strftime("%d-%b-%Y")
        
        return formatted_date
    
    except ValueError as e:
        raise ValueError(f"Invalid date format. Expected DD-MM-YYYY, got: {date_string}") from e


def extract_value_by_comma_separated(input_string):
    """
    Extracts a value from a comma-separated string based on the provided index.
    
    Args:
        input_string (str): Comma-separated string (e.g., "apple,banana,cherry")
        index (int): Index of the value to extract (0-based)
    """
    values = [i for i in input_string.split(',')]
    return values

# print(extract_value_by_seprated_comma("No adverse event reported"))

def remove_version_from_aer_number(aer_number):
    # Remove anything in parentheses from the AER number
    aer_number_clean = re.sub(r'\(\d+\)', '', str(aer_number))
    return aer_number_clean.strip()

# print(remove_version_from_aer_number("20251200376(11)"))  # Output: AER123456    

