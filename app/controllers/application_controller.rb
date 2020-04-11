class ApplicationController < ActionController::Base
  before_action :load_sections
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
    def record_not_found(exception)
      case exception.model
      when 'User'
        message = 'O usuário que você está procurando não pôde ser encontrado.'
      when 'Section'
        message = 'A seção que você está procurando não pôde ser encontrada.'
      when 'Topic'
        message = 'O tópico que você está procurando não pôde ser encontrado.'
      when 'Post'
        message = 'O post que você está procurando não pôde ser encontrado.'
      end

      render 'errors/404', locals: { message: message }
    end

    def sort_topics(topics)
      topics.sort_by do |topic|
        if topic.posts.empty?
          -(topic.created_at.to_f)
        else
          -(topic.posts.last.created_at.to_f)
        end
      end
    end

    def load_sections
      @section_list = Section.all
    end

    def current_user
      @current_user ||= session[:user_id] && User.find(session[:user_id])
    end

    def find_post_position(post)
      post_position = post.topic.posts.order(:created_at).map { |post| post.id } .index(post.id)
    end

    def find_post_page(post)
      post_position = find_post_position(post) + 2
      return (post_position.to_f / 10).ceil
    end

    def self.replace_color(msg, indexes)
      middle_text = msg.slice(indexes[:o_e]...indexes[:c_s])
      tag = msg.slice(indexes[:o_s]...indexes[:o_e])
      code = /code=([^\] ]+)/.match(tag)[1];
      span = '<span style="color: ' + code + '">'
      span += middle_text
      span += '</span>'
      return span
    end
    
    def self.replace_link(msg, indexes)
      middle_text = msg.slice(indexes[:o_e]...indexes[:c_s])
      anchor = '<a href="' + middle_text + '">'
      anchor += middle_text
      anchor += '</a>'
      return anchor
    end
    
    def self.replace_spoiler(msg, indexes)
      middle_text = msg.slice(indexes[:o_e]...indexes[:c_s])
      span = '<span class="spoiler">'
      span += middle_text
      span += '</span>'
      return span
    end
    
    def self.replace_video(msg, indexes)
      middle_text = msg.slice(indexes[:o_e]...indexes[:c_s])
      cleaned_link = middle_text.sub('watch?v=', 'embed/');
    
      frame = '<iframe src="' + cleaned_link + '" frameborder="0">'
      frame += '</iframe>'
    
      video = '<div class="video">'
      video += frame
      video += '</div>'
      return video
    end
    
    def replace_tags(msg)
      copy = msg.dup
      parsed_msg = ''
      i = 0
      while i < copy.length do
        parsed_msg += copy[i]
        if copy[i] == '['
          tag_name = ''
          j = i + 1
    
          # It must not find a closing tag
          if copy[j] == '/'
            i += 1
            next
          end
    
          # Make tag's name
          while copy[j] != ' ' && copy[j] != ']'
            tag_name += copy[j]
            j += 1
          end
    
          regex = Regexp.new('\[\/?' + tag_name + '.*?\]', Regexp::EXTENDED)
          match = regex.match(copy, i)
          opening_tag_starting_index = match.offset(0)[0]
          opening_tag_ending_index = match.offset(0)[1]
    
          tags_with_no_pair = 1
          while tags_with_no_pair > 0 do
            starting_point = match.offset(0)[1]
            match = regex.match(copy, starting_point)
            if !match
              break
            end
    
            if match[0][1] != '/'
              tags_with_no_pair += 1
            else
              tags_with_no_pair -= 1
            end
          end

          if tags_with_no_pair == 0
            closing_tag_starting_index = match.offset(0)[0]
            closing_tag_ending_index = match.offset(0)[1]
            indexes = {
              o_s: opening_tag_starting_index,
              o_e: opening_tag_ending_index,
              c_s: closing_tag_starting_index,
              c_e: closing_tag_ending_index
            }
            
            if tag_name != 'quote'
              if ($functions.key?(tag_name))
                subtext = $functions[tag_name].call(copy, indexes)
                parsed_msg = parsed_msg.slice(0...parsed_msg.length-1) + subtext
                i = 0
                copy = copy.slice(closing_tag_ending_index...copy.length)
              else
                i += 1
              end

              next
            end
    
            middle_text = copy.slice(opening_tag_ending_index...closing_tag_starting_index) || ''
            tag = copy.slice(opening_tag_starting_index...opening_tag_ending_index) || ''
            code_match = /code=([^\] ]+)/.match(tag);
            author_match = /author=([^\] ]+)/.match(tag);
    
            if !code_match || !author_match
              i = 0
              copy = copy.slice(closing_tag_ending_index...copy.length)
              next
            end
    
            author = author_match[1]
            code = code_match[1]
            info = code.split('/')
            post_id = info[0]
            topic_id = info[1]
            its_op = info[2]
    
            # Link to quoted post
            path = ''
            if its_op != '0'
              path = '/topics/' + topic_id + '#op-post'
            else
              path = '/posts/' + post_id
            end
            
            post_link = '<a href="' + path + '">'
            post_link += author + ':'
            post_link += '</a>'
    
            # Quote header
            header = '<div class="header">'
            header += post_link
            header += '</div>'
            
            # Put text inside content div and replace tags recursively
            content = '<div class="content">'
            content += replace_tags(middle_text)
            content += '</div>'
            
            # Make quoting block
            quote = '<div class="quote">'
            quote += header
            quote += content
            quote += '</div>'
    
            parsed_msg = parsed_msg.slice(0...parsed_msg.length-1) + quote
    
            i = 0
            copy = copy.slice(closing_tag_ending_index...copy.length)
            next
          end
        end
    
        i += 1
      end
    
      return parsed_msg
    end
    
    $functions = {
      'color' => method(:replace_color),
      'link' => method(:replace_link),
      'spoiler' => method(:replace_spoiler),
      'video' => method(:replace_video)
    }

  helper_method :current_user, :find_post_position, :find_post_page
end
