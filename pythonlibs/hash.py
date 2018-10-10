import uuid
import hashlib
import random

def random_6_digits():
    return ''.join([str(random.randint(0,9)) for i in xrange(6)])

def get_type(val):
    return type(val)

def generate_uuid(prefix=''):
    return prefix+str(uuid.uuid1())

def hash_sha1(content):
    return hashlib.sha1(content).hexdigest().lower()

def hash_sha256(content):
    return hashlib.sha256(content).hexdigest().lower()