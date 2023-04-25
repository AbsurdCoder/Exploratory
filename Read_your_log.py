import spacy
from spacy.util import minibatch, compounding
from spacy.training.example import Example

def train_ner_model(train_data, iterations):
    # Create a blank English model
    nlp = spacy.blank("en")

    # Add the NER pipeline
    ner = nlp.add_pipe("ner")

    # Add the custom labels to the NER pipeline
    for _, annotations in train_data:
        for ent in annotations.get("entities"):
            ner.add_label(ent[2])

    # Train the NER model
    optimizer = nlp.begin_training()
    for itn in range(iterations):
        for batch in minibatch(train_data, size=compounding(4.0, 32.0, 1.001)):
            for text, annotations in batch:
                example = Example.from_dict(nlp.make_doc(text), annotations)
                nlp.update([example], sgd=optimizer)
    
    return nlp

nlp = train_ner_model(TRAIN_DATA, 30)

with open('log_file.log', 'r') as file:
    log_data = file.readlines()


def process_event(event_data):
    event = {}
    for ent in event_data.ents:
        event[ent.label_] = ent.text
    return event

log_events = []
for line in log_data:
    doc = nlp(line.strip())
    log_events.append(process_event(doc))

print(log_events)
