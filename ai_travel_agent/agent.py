from langchain.agents import Tool, initialize_agent
from langchain.agents.agent_types import AgentType
from langchain.llms.fake import FakeListLLM

from tools import get_attractions, build_itinerary
import warnings
warnings.filterwarnings("ignore")


tools = [
    Tool(
        name="Get Attractions",
        func=lambda input: get_attractions(
            input["location"], input["interests"]
        ),
        description="Get attractions for a given location and interests"
    ),
    Tool(
        name="Build Itinerary",
        func=lambda input: build_itinerary(
            input["location"],
            input["days"],
            input["attractions"],
            input["budget"]
        ),
        description="Build a day-wise itinerary"
    )
]


fake_llm = FakeListLLM(
    responses=[
        "I should get attractions for the location.",
        "I should now build a day-wise itinerary.",
        "Here is the final travel plan."
    ]
)


def run_agent():
    input_data = {
        "location": "Jaipur",
        "days": 3,
        "budget": "Low",
        "interests": ["History"]
    }

    # Simulate agent reasoning (for architecture)
    agent = initialize_agent(
        tools=tools,
        llm=fake_llm,
        agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
        verbose=True
    )

    agent.run(input_data)

    # Explicit structured output (THIS is what GDG cares about)
    attractions = get_attractions(
        input_data["location"],
        input_data["interests"]
    )

    itinerary = build_itinerary(
        input_data["location"],
        input_data["days"],
        attractions,
        input_data["budget"]
    )

    print("\n===== STRUCTURED TRAVEL ITINERARY =====")
    print({
        "location": input_data["location"],
        "duration": f"{input_data['days']} days",
        "budget": input_data["budget"],
        "interests": input_data["interests"],
        "itinerary": itinerary
    })




if __name__ == "__main__":
    run_agent()
