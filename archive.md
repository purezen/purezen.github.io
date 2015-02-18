---
layout: page
title: Archives
description: "An archive of posts sorted by year."
---

<div class="posts">
  {% for post in site.posts %}
    {% capture this_year %}{{ post.date | date: "%Y" }}{% endcapture %}
    {% capture next_year %}{{ post.previous.date | date: "%Y" }}{% endcapture %}

    {% if forloop.first %}
    <h2 id="{{ this_year }}-ref">{{this_year}}</h2>
    <ul>
    {% endif %}

  <div class="index-post">
    <h2 class="post-title">
      <a href="{{ post.url }}">
        {{ post.title }}
      </a>
    </h2>

    <span style="float: right;" class="tag-box inline post-tag">
      {% for tag in post.tags %}
        {% if tag == post.tags.last %}
          <a href="{{ site.baseurl }}tags/#{{tag}}">
            {{ tag }}
          </a>
        {% else %}
          <a href="{{ site.baseurl }}tags/#{{tag}}">
            {{ tag }}
          </a>
          &middot;
        {% endif %}
      {% endfor %}
    </span>

    <span class="post-date">
      {{ post.date | date_to_string }}
    </span>
  </div>

    {% if forloop.last %}
    </ul>
    {% else %}
    {% if this_year != next_year %}
    </ul>
    <h2 id="{{ next_year }}-ref">{{next_year}}</h2>
    <ul>
    {% endif %}
    {% endif %}
  {% endfor %}
</div>
