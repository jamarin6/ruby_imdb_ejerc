require 'spec_helper'
require 'cinema'
require 'movie'

describe Cinema do
  describe 'add' do
    it 'adds a movie to our listing' do
      cinema = Cinema.new
      pako = double('Pako', {title: 'Top Gun', director: 'Director'})#
      cinema.add_movie(pako)#

      #cinema.add_movie(Movie.new('Top Gun', 'Action', 'Tony Scott', Date.new(1986, 5, 16)))

      expect(cinema.listing).to include('Top Gun')
    end
  end

  describe 'remove' do
    it 'remove a movie from our listing' do
      cinema = Cinema.new
      pako = double('Pako',{title: 'Top Gun', director: 'Tony Scott'})

      cinema.remove_movie(pako)

      expect(cinema.listing).to_not include('Top Gun')
    end
  end

  describe 'listing' do
    let(:cinema) do
      die_hard_Db = double('die_hard_Db',{title: 'Die Hard', director: 'John McTiernan'})
      aladdin_Db = double('aladdin_Db',{title: 'Aladdin', director: 'Ron Clements'})
      clerks_Db = double('clerks_Db',{title: 'Clerks', director: 'Kevin Smith'})

      Cinema.new([die_hard_Db, aladdin_Db, clerks_Db])
    end

    it 'returns an array with the title of our movies' do
      titles = cinema.listing

      expect(titles).to include('Die Hard')
      expect(titles).to include('Aladdin')
      expect(titles).to include('Clerks')
    end

    it 'returns the movies ordered by title' do
      titles = cinema.listing

      expect(titles[0]).to eq('Aladdin')
      expect(titles[1]).to eq('Clerks')
      expect(titles[2]).to eq('Die Hard')
    end
  end

  describe 'group_by_genre' do
    it 'group the movies of the cinema by genre' do
     
      die_hard_Db = double('die_hard_Db',{title: 'Die Hard', genre: 'Action', director: 'John McTiernan'})
      aladdin_Db = double('aladdin_Db',{title: 'Aladdin', genre: 'Animation', director: 'Ron Clements'})
      clerks_Db = double('clerks_Db',{title: 'Clerks', genre: 'Comedy', director: 'Kevin Smith'})
      cinema = Cinema.new([die_hard_Db, aladdin_Db, clerks_Db])

      titles = cinema.group_by_genre

      expect(titles['Action']).to include('Die Hard')
      expect(titles['Action'].length).to eq(1)

      expect(titles['Animation']).to eq(['Aladdin'])

      expect(titles.length).to eq(3)
    end
  end

  describe 'movies_per_genre' do
    it 'counts the number of movies in each genre' do

      die_hard_Db = double('die_hard_Db',{title: 'Die Hard', genre: 'Action', director: 'John McTiernan'})
      aladdin_Db = double('aladdin_Db',{title: 'Aladdin', genre: 'Animation', director: 'Ron Clements'})
      clerks_Db = double('clerks_Db',{title: 'Clerks', genre: 'Comedy', director: 'Kevin Smith'})
      aladdin2_Db = double('Aladdin 2_Db',{title: 'Aladdin 2', genre: 'Animation', director: 'Toby Shelton'})
      cinema = Cinema.new([die_hard_Db, aladdin_Db, clerks_Db, aladdin2_Db])

      histogram = cinema.movies_per_genre

      expect(histogram['Action']).to eq(1)
      expect(histogram['Animation']).to eq(2)
      expect(histogram['Comedy']).to eq(1)
    end
  end

  describe 'similar_movies' do
    it 'returns the titles of similar movies' do
      die_hard = Movie.new('Die Hard', 'Action', 'John McTiernan', Date.new(1988, 7, 22))
      aladdin = Movie.new('Aladdin', 'Animation', 'Ron Clements', Date.new(1992, 11, 25))
      aladdin2 = Movie.new('Aladdin 2', 'Animation', 'Toby Shelton', Date.new(1994, 5, 20))
      clerks = Movie.new('Clerks', 'Comedy', 'Kevin Smith', Date.new(1994, 11, 30))
      cinema = Cinema.new([die_hard, aladdin, aladdin2, clerks])

      up = Movie.new('Up', 'Animation', 'Pete Docter', Date.new(2009, 5, 29))

      similar_movies = cinema.similar_movies(up)

      expect(similar_movies).to include('Aladdin')
      expect(similar_movies).to include('Aladdin 2')
      expect(similar_movies.length).to eq(2)
    end
  end
end