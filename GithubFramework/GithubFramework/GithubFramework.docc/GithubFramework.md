# ``GithubFramework``

A framework to get GitHub repository information.

## Overview

GithubFramework is an iOS framework that simplifies interaction with the GitHub API. It provides functionalities to fetch user repositories and repository tags, manage local data storage, and handle network requests in a clean and modular way.

## Features

- Fetch Repositories: Easily retrieve repositories for a specified GitHub user.
- Fetch Repository Tags: Fetch tags for a specific repository.
- Local Data Management: Store and retrieve user repositories and tags locally.
- Network Handling: Perform network requests and decode data into model objects.

## Installation

### CocoaPods

To integrate GithubFramework into your project using CocoaPods, add the following line to your Podfile:

```
pod 'GithubFramework'
```

Then, run the following command to install the framework:

```
pod install
```

## Usage

### Importing the Framework

Import the framework into your project files:

```
import <GithubFramework/GithubFramework.h>
```

### Fetching User Repositories

To fetch repositories for a user, use the RemoteDataSource class:

```
[[RemoteDataSource sharedManager] getRepositoriesForUser:@"username" completion:^(NSArray *repositories, NSError *error) {
    if (error) {
        // Handle error
    } else {
        // Use the retrieved repositories
    }
}];
```

### Fetching Repository Tags

Similarly, to fetch tags for a repository:

```
[[RemoteDataSource sharedManager] getTagsForRepository:@"tagsURL" completion:^(NSArray *tags, NSError *error) {
    if (error) {
        // Handle error
    } else {
        // Use the retrieved tags
    }
}];
```

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Contact
For questions or feedback, please reach out to ana9lu7@gmail.com

