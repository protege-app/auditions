# Protégé iOS Interview Project

## Problem

Your task is to create an app that fetches and displays a list of past SpaceX rocket launches. Users should be able to watch videos of the launches and read news/wikipedia articles.

This project should take between 1-2 hours to complete. Please stay within that time frame.

**Requirements**

- Fetch past SpaceX launches using the `launchesPast` query from the [SpaceX GraphQL API](https://api.spacex.land/graphql/) and display the launches in a list
- Each launch should display:
	- Mission name
	- Launch site name
	- Load the mission patch image
	- Load the thumbnail from the video link
	- Display a formatted launch date
- Launches should be sorted by the most recent launch date
- Provide a way for users to view each launch's `video_link`, `article_link`, and `wikipedia` link
- Add pagination to the `launchesPast` query and load more launches using the `offset` variable

## Resources

### SpaceX GraphQL API

Please use the [SpaceX GraphQL API](https://api.spacex.land/graphql/) for downloading the list of past launches.

```
query {
  launchesPast(limit: 10, offset: 0) {
    launch_date_local
    launch_site {
      site_name_long
    }
    links {
      article_link
      video_link
      mission_patch_small
      wikipedia
    }
    mission_name
  }
}
```

### Loading Thumbnails from YouTube

To load thumbnails from the launch's `video_link` you'll need to extract the YouTube video ID and request the image with the following URL:

```
https://img.youtube.com/vi/<insert-youtube-video-id>/maxresdefault.jpg
```
