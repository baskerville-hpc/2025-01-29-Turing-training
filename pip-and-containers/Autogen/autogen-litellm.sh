#!/bin/bash

# Copyright 2023 University of Birmingham, ResearchSoftwareGroup 
 

source ./multiagent_coalitions-dev/LLM_RAG/Corpus_env/bin/activate

llama pull codellama # OUR Local CodeLlama  
litellm --model ollama/codellama --temperature 0.3 --max_tokens 2048


