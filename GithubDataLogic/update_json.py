import json
from pprint import pprint

class GithubAccounts(object):
    """docstring for ClassName"""

    def __init__(self):
        super(GithubAccounts, self).__init__()

    @staticmethod
    def open_file(file_path):
        with open(file=file_path) as data_file:
            data = json.load(data_file)

        return data

    @staticmethod
    def write_file(file_path, data):
        with open(file=file_path, mode="w") as data_file:
            data_file.write(json.dumps(data))

        data_file.close()

    @staticmethod
    def get_list_of_all_vals_for_specific_key(data_set_list, key_name):
        username_list = list()
        for account in data_set_list:
            username = account.get(key_name)
            if username is not None:
                username_list.append(username)

        return username_list


if __name__ == '__main__':
    github_acct_logic = GithubAccounts()

    contributions_and_top_repos = GithubAccounts.open_file('../contributions_and_top_repos.json')
    user_collection = GithubAccounts.open_file('../data.json')

    user_hash = {user['github_username']: user for user in user_collection}

    for username, value in contributions_and_top_repos.items():
        user_hash[username].update({'contributions': value.get('contributions')})
        user_hash[username].update({'top_repos': value.get('top_repos')})


    pprint(contributions_and_top_repos)
    pprint(user_collection)
    pprint(user_hash)

    GithubAccounts.write_file('../user_collection_data.json', user_hash)





