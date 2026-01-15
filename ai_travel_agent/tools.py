from typing import List, Dict


def get_attractions(location: str, interests: List[str]) -> List[str]:
    """
    Returns a list of attractions based on location and interests.
    This uses mock data for simplicity.
    """
    attractions_db = {
        "jaipur": ["Amber Fort", "Hawa Mahal", "City Palace", "Jantar Mantar"],
        "paris": ["Eiffel Tower", "Louvre Museum", "Notre Dame"],
        "rome": ["Colosseum", "Roman Forum", "Pantheon"]
    }

    return attractions_db.get(location.lower(), ["Local sightseeing", "City tour"])


def build_itinerary(
    location: str,
    days: int,
    attractions: List[str],
    budget: str
) -> Dict[str, List[str]]:
    """
    Builds a simple day-wise itinerary.
    """
    itinerary = {}
    index = 0

    for day in range(1, days + 1):
        itinerary[f"Day {day}"] = attractions[index:index + 2]
        index += 2

    return itinerary
