# Astana IT University: Blockchain Hack 2023 

## Project name

__Chaingen__

## Selected problem

__LLM-generated blockchain node deployment script__

## Team name

__DNA__

## Participants

* Danial Baitakov. Email: 230408@astanait.edu.kz
* Nurlan Kurmetov. Email: 230383@astanait.edu.kz
* Ansar Shangilov. Email: 230720@astanait.edu.kz

## Abstract

ChainGen simplifies setting up blockchain nodes with smart technology, saving time and effort. Its user-friendly interface and clever decision-making make managing blockchain nodes easy. ChainGen aims to make blockchain tech more accessible, efficient, and user-friendly for everyone.

## Demo video

[Link to a demo video showcasing your project, if any. Ensure it is less than 3 minutes long.]

## How to run

### Prerequisites:

- Python 3.11

All other needed libraries are included in `requirements.txt`. See below.

### Running

Basic example:
```bash
# Clone the repository
git clone https://github.com/qixdev/chaingen.git

# Navigate to the project directory
cd chaingen

# Install all dependencies
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install -r requirements.txt

# Setup your api key
# Create a file called .env
nano .env
# Write you api key like this: "API_KEY=[YOUR OPENAI API KEY]

# Run the application
python app.py
```

## Inspirations

Our main inspiration was having an experience of creating useful programms that can be deployed and used worldwide. We were inspired by the website called privacy.sexy, that also generates scripts for keeping yourself private.

## Technology stack and organization

Our team consists of 3 members: Danial, Nurlan, Ansar -> that's why team called DNA.
    - Danial is the captain of the team that is responsible for backend, connection with LLM and management.
    - Nurlan is designer of our team and he is responsible for design of our website.
    - Ansar is our most experienced in blockchain team member. He is responsible for creating default bashscripts and contibuting to prompting LLM.
Although, there is selected responsobilities, there was no bound in helping to each other, we did everything together but to a different extent.
As our main part is website, we've used Python and it's very known framework - Flask
For LLM standing behind of generating scripts we've used ChatGPT-4-turbo, that can process up to 128k tokens and default api for it.


## Solutions and features implemented

We have developed a website, where user can type his request or documenation and get the script, behind this process there is a prompting a LLM which is chatGPT connected by default api and checking the script generated by LLM. So checking was the hardest and easiest to solve at the same time. Our captain constructed a script that checks if node is running by checking used ports before executing the script at server machine. After that program executes generated script and again checks for ports that used by machine. If the result of the first check does not match the second, the node is considered to be running successfully. Another solution would be parsing the output of the script and matching it with regex, searching for flags like "ERROR", or something like that. Once a user receives their script, they can share a link for others to download and return to the same script by inserting the generated script's link. Our main feature is providing scripts that work almost on any OS, it is done by checking user's os and installing needed tools with `curl` that is installed on the most popular OSs.

## Challenges faced

Project itself was simple, but not easy. We faced many challenges, starting from simple `pip install` that we were laughing on, going to checking that a node is running. The hardest challenge was to optimize LLM's prompts to give correct scripts as even GPT-4 was limited by it's knowledge about deploying nodes, and it consequenced another challenge, which was constructing default scripts for GPT to process before generating new script. Also one of the hardest challenge was checking of running of the node, but it appeared to be solved easily. 

## Lessons learned

Our team members wasn't really specified on this field and hadn't participated on hackathons related to blockchain and we had a lot to learn about it. Some teammates touched bash for the first time, but got very experienced in it after some time. Also we've experienced using OpenAI API in project, as we didn't had any experience with LLM APis and we've learned to keep our API_KEY out of git vision to avoid leak.

## Future work

- Authorization for keeping history of scripts
- Feed of all generated scripts
- Optimization of the code
- Reimplement project using Docker and Golang for faster deployment and use
- Add new frontend technologies, such as Angular, React
- Getting hosted
- Checkboxes for default scripts, like bitcoin, ethereum and other most popular blockchains.
- Optimize LLM prompt
- Double check script with searching signs of error in output of the script in addition to comparing used prompts.

## Additional sources

- "Quickstart: Run a node and (optionally) stake ETH using Prysm"
https://docs.prylabs.network/docs/install/install-with-script
- "Bitcoin-Cli" 
https://chainquery.com/bitcoin-cli 
- "Quick Node"
https://www.quicknode.com/
- "Deploy your own Local Ethereum PoS Testnet"
https://github.com/rzmahmood/ethereum-pos-testnet#readme
- "How to deploy a local private Ethereum blockchain"
https://medium.com/datawallet-blog/how-to-deploy-a-local-private-ethereum-blockchain-c2b497f068f4
- "SPIN UP YOUR OWN ETHEREUM NODE" 
https://ethereum.org/en/developers/docs/nodes-and-clients/run-a-node/
- "Create an Ethereum blockchain node"
https://ethereum.org/en/developers/docs/nodes-and-clients/run-a-node/
- https://web3.career/learn-web3/top-blockchain-open-source-projects
- https://btcinformation.org/en/developer-documentation