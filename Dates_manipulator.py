
from datetime import datetime, timedelta

def add_days(date_str, days, date_format="%Y-%m-%d"):
    """
    Adds a number of days to a date string.
    :param date_str: Date as a string
    :param days: Number of days to add (can be negative)
    :param date_format: Format of the input and output date string
    :return: New date as a string
    """
    date_obj = datetime.strptime(date_str, date_format)
    new_date = date_obj + timedelta(days=days)
    return new_date.strftime(date_format)

def format_date(date_obj, date_format="%Y-%m-%d"):
    """
    Formats a datetime object as a string.
    :param date_obj: datetime object
    :param date_format: Desired string format
    :return: Formatted date string
    """
    return date_obj.strftime(date_format)

def parse_date(date_str, date_format="%Y-%m-%d"):
    """
    Parses a date string into a datetime object.
    :param date_str: Date as a string
    :param date_format: Format of the input date string
    :return: datetime object
    """
    return datetime.strptime(date_str, date_format)

def _convert_format(user_format):
    """
    Converts user-friendly date format to Python strftime format.
    """
    mapping = {
        "DD/MM/YYYY": "%d/%m/%Y",
        "MM/YYYY": "%m/%Y",
        "YYYY": "%Y",
        "DD/MM/YYYY HH.MM.SS": "%d/%m/%Y %H.%M.%S"
    }
    return mapping.get(user_format, user_format)



def generate_dates_from_current(diff_days, start_date_format="DD/MM/YYYY", end_date_format="DD/MM/YYYY", condition="start_date<end_date"):
    """
    Generates two dates from the current date based on the user format and condition.
    Supported user formats:
        - "DD/MM/YYYY"
        - "MM/YYYY"
        - "YYYY"
        - "DD/MM/YYYY HH.MM.SS"
    Supported conditions:
        - "start_date<end_date"
        - "start_date>end_date"
        - "start_date=end_date"
    :param diff_days: Number of days difference
    :param start_date_format: Format for start date
    :param end_date_format: Format for end date
    :param condition: Condition between start and end date
    :return: Tuple of (start_date, end_date) as strings
    """
    diff_days += 1    
    start_date_format = _convert_format(start_date_format)
    end_date_format = _convert_format(end_date_format)
    current_date = datetime.now()

    # Calculate start and end dates based on format
    if start_date_format == "%m/%Y":          
        if diff_days == 1:
            start = current_date.strftime(start_date_format)        
            end = (current_date - timedelta(days=0)).strftime(end_date_format)
        else:
            start = current_date.strftime(start_date_format)        
            end = (current_date - timedelta(days=diff_days)).strftime(end_date_format)
    elif start_date_format == "%Y":
        start = current_date.strftime(start_date_format)
        if diff_days == 1:
            end = (current_date - timedelta(days=0)).strftime(end_date_format)
        else:
            end = (current_date - timedelta(days=diff_days)).strftime(end_date_format)
    elif start_date_format == "%d/%m/%Y %H.%M.%S":        
        if diff_days == 1:
            start = (current_date - timedelta(days=0)).strftime(start_date_format)
            end = (current_date - timedelta(days=1)).strftime(end_date_format)
        else:
            start = (current_date - timedelta(days=1)).strftime(start_date_format)
            end = (current_date - timedelta(days=diff_days)).strftime(end_date_format)
    else:  # Default "%d/%m/%Y"        
        if diff_days == 1:
            start = (current_date - timedelta(days=0)).strftime(start_date_format)
            end = (current_date - timedelta(days=0)).strftime(end_date_format)
        else:
            start = (current_date - timedelta(days=1)).strftime(start_date_format)
            end = (current_date - timedelta(days=diff_days)).strftime(end_date_format)

    # Adjust the order based on condition
    if condition == "start_date<end_date":
        # For this condition, start date should be more recent (larger)
        dates = tuple(sorted([start, end], reverse=True))
    elif condition == "start_date>end_date":
        # For this condition, start date should be older (smaller)
        dates = tuple(sorted([start, end]))
    elif condition == "start_date=end_date":
        dates = (start, start)
    else:
        raise ValueError(f"Unsupported condition: {condition}")

    return dates

# print(generate_dates_from_current(diff_days=7, condition="start_date>end_date"))

def calculate_date_difference(date1, date2, date1_format="%d-%m-%Y", date2_format="%d-%b-%Y"):
    d1 = datetime.strptime(date1, date1_format)
    d2 = datetime.strptime(date2, date2_format)
    return (d2 - d1).days

# Example usage
# if __name__ == "__main__":
#     diff = 0
    # Example usage for all user formats and conditions
    # for fmt in [("DD/MM/YYYY","DD/MM/YYYY"), ("MM/YYYY", "MM/YYYY"), ("YYYY", "YYYY"), ("DD/MM/YYYY HH.MM.SS", "DD/MM/YYYY")]:
    #     for cond in ["start_date<end_date", "start_date>end_date", "start_date=end_date"]:
    #         date1, date2 = generate_dates_from_current(diff, fmt[0], fmt[1], cond)
    #         print(f"Format: {fmt}, Condition: {cond}")
    #         print(date1)
    #         print(date2)

# import  pytesseract
# import easyocr
# from PIL import Image
# import numpy as np
# def solve_capt(screens):
#     text= pytesseract.image_to_string(Image.open(screens)).strip()
#     return text
# def extract_text_from_image(image_path):
#     from PIL import Image, ImageEnhance

#     # Open and enhance image contrast
#     img = Image.open(image_path)
#     enhancer = ImageEnhance.Contrast(img)
#     img = enhancer.enhance(2.0)  # Increase contrast

#     reader = easyocr.Reader(['en'])
#     # Use allowlist to restrict recognition to alphanumeric characters
#     results = reader.readtext(
#         np.array(img),
#         detail=0,
#         allowlist='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
#     )
#     text = ''.join(results)
#     return text
def calculate_date_difference_month_name(date1, date2, date1_format="%d-%b-%Y", date2_format="%d-%b-%Y"):
    d1 = datetime.strptime(date1, date1_format)
    d2 = datetime.strptime(date2, date2_format)
    return (d2 - d1).days