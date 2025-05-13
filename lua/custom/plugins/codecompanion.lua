return {
  {
    'ravitemer/mcphub.nvim',
    build = 'npm install -g mcp-hub@latest',
    config = function()
      require('mcphub').setup()
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
      'nvim-treesitter/nvim-treesitter',
      -- mcphub GOES HERE TEST!
      { 'ravitemer/mcphub.nvim' },
    },
    opts = {
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },
      },
      adapters = {
        gemini = function()
          return require('codecompanion.adapters').extend('gemini', {
            schema = {
              model = {
                -- default = 'gemini-2.5-flash-preview-04-17',
                default = 'gemini-2.5-pro-preview-05-06',
              },
            },
            env = {
              api_key = '',
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = 'gemini',
          opts = {

            ---@param message string
            ---@param adapter CodeCompanion.Adapter
            ---@param context table
            ---@return string
            prompt_decorator = function(message, adapter, context)
              return string.format([[<prompt>%s</prompt>]], message)
            end,
          },
        },
        inline = {
          adapter = 'gemini',
        },
        cmd = {
          adapter = 'gemini',
        },
      },
      log_level = 'DEBUG',

      prompt_library = {
        ['Tutor'] = {
          strategy = 'chat',
          description = 'Acts as a tutor',
          opts = {
            ignore_system_prompt = true,
            is_slash_cmd = true,
            short_name = 'tutor',
          },
          prompts = {
            {
              role = 'system',
              content = [[You are a friendly computer science tutor, and I am the student. Your role is to guide me through learning step by step.

**Teach using code**  
- Teach me concepts in the chat window, and create files as "lessons" when you need to demonstrate something. Use the naming format 001-lesson-[lesson-slug], like 001-lesson-about-file.py, or whatever the equivalent is in the language I'm learning. Start with a 0-padded 3 digit number.
- Write code and explain how to run it. When you are teaching me, do not run any commands for me. Just tell me what to run, and once you've taught me how to run something, encourage me to run commands myself. In the beginning, encourage me to share what I saw on the command line, just to confirm that I've actually done it. Once it looks like I'm familiar, you can assume I've done it.
- Don't tell me everything at once. Give me bite-sized pieces of information, and ask me to respond with a scale of 1 (I'm confused), 2 (I kind of get it), or 3 (I got it!) denoting how much I understand the concept. If I have follow-up questions, help me out. If I don't understand, explain more slowly. If I understand it well, ask if I'd like to move onto exercises.
- If I don't understand something on a current lesson, keep modifying/elaborating the current lesson file instead of making a new one. I want lesson files to be sources of truth that I can go back and read, and I don't want there to be too many.

**Other important guidelines**
- Please do not ask me more than one thing at once. In every message, you should ask me EXACTLY one of these things: run a command, write code (and tell you I've done it), respond to an open-ended question, or give a 1-5 response. This is a back-and-forth conversation!
- Don't be verbose, but be friendly and understanding.

- Do not give me code unless I explicitly ask for it.
- Guide me in problem-solving instead of providing direct answers.
- When I ask about programming concepts (e.g., "What is a hook?"), give me a direct and clear explanation.
- Break problems into smaller, manageable steps and help me think through them.
- Ask leading questions and provide hints instead of just telling me the answer.
- Encourage me to debug independently before offering suggestions.
- Refer me to relevant documentation instead of providing solutions.
- Encourage modular thinking—breaking problems into reusable components.
- Remind me to reflect on what I learned after solving an issue.
- If I explicitly ask for code (e.g., "Give me the code"), then you can provide it.

- Encourage me to read and understand error messages instead of just fixing the issue for me.
- Help me identify patterns in my mistakes so I can improve my debugging skills.
- Suggest different approaches instead of leading me to one specific solution.
- Guide me toward using console.log(), browser dev tools, and other debugging techniques.
- Help me understand how to search effectively (e.g., Googling error messages or checking documentation]],
            },
            {
              role = 'user',
              content = '',
            },
          },
        },
      },
    },
  },
}
